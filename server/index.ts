export { };

const { GraphQLServer } = require('graphql-yoga');

// Setup for API requests
import * as secrets from "./secrets.json";
const querystring = require('querystring');
const fetch = require('node-fetch');

// Get schema (type defs)
const fs = require('fs');
const path = require('path');
const typeDefs = fs.readFileSync(path.join(__dirname, "schema.graphql"), "utf8");

const rapidapi = {
    headers: {
        "x-rapidapi-key": secrets['RAPID_API'],
        "useQueryString": true
    }
}

const resolvers = {
    Team: {
        name: (parent) => {
            return parent.team_name || parent.name;
        }
    },
    Player: {
        /** Grabs the url to the first image from Bing matching desired player headshot. */
        urlToImage: async (parent) => {
            const name = parent.player_name;
            const query = querystring.encode({
                count: "1",
	            q: `${name} soccer headshot`
            });

            const baseURL = `https://bing-image-search1.p.rapidapi.com/images/search?${query}`;
            const response = await fetch(baseURL, rapidapi);
            const parsed = await response.json();

            return parsed.value[0].thumbnailUrl;
        }
    },
    Standing: {
        /** Get last 5 games of given team */
        latest_games: async (parent) => {
            const team_id: String = parent.team_id;
            const LIMIT_TO = 5;

            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/team/${team_id}/last/${LIMIT_TO}`, rapidapi);
            const parsed = await response.json();

            return parsed.api.fixtures;
        },
        /** Get total goal average statistic of given team */
        goal_averages: async (parent) => {
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/statistics/2/${parent.team_id}`, rapidapi);
            const parsed = await response.json();

            const goal_averages = parsed.api.statistics.goalsAvg;
            const goalsForAvgTotal = goal_averages.goalsFor.total;
            
            return goalsForAvgTotal;
        },
        /** Get goalie of given team */
        goalie: async (parent) => {
            const team_id = parent.team_id;
            const year = 2019;  // TODO: get from datetime
            
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/players/squad/${team_id}/${year}`, rapidapi)
            const parsed = await response.json();
            
            const goalie = parsed.api.players.filter((player)=>player.position=="Goalkeeper");            
            return goalie[0] || null;
        }
    },
    GameResult: {
        score: (parent) => {
            return parent.score.fulltime;
        }
    },
    Query: {
        /** Gets all the teams in a particular league. */
        teams: async (_) => {
            console.log('teams requested');
            const league_id = 2;
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/teams/league/${league_id}`, rapidapi);
            const parsed = await response.json();
            return parsed.api.teams;
        },
        /** Gets last 10 games in league */
        games: async (_) => {
            const league_id = 524;
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/league/${league_id}/last/10`, rapidapi);
            const parsed = await response.json();
            return parsed.api.fixtures;
        },
        /** Gets latest soccer news articles */
        notices: async (_) => {
            const query = 'soccer';
            const response = await fetch(
                `http://newsapi.org/v2/everything?q=${query}&` +
                'from=2020-09-08&' +
                'sortBy=popularity&' +
                `apiKey=${secrets["NEWS_API"]}`
            );
            const parsed = await response.json();

            return parsed.articles;
        },
        /** Query to compare the teams according to an array of team names passed in */
        compareTeams: async (_, { teamNames }) => {
            const league_id = 524; // TODO: Get league_id from teamName search

            // GET team standings throughout league.
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/leagueTable/${league_id}`, rapidapi);
            const parsed = await response.json();

            // Filter to just the 2 teams requested
            const teamsToCompare = parsed.api.standings[0].filter((element, index, array) => { 
                return teamNames.includes(element.teamName);
            });

            return teamsToCompare;
        }
    }
}

const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));