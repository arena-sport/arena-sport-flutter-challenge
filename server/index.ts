export { };

import * as secrets from "./secrets.json";

const { GraphQLServer } = require('graphql-yoga');
const fetch = require('node-fetch');

// Get type definitions
const fs = require('fs');
const path = require('path');
const typeDefs = fs.readFileSync(path.join(__dirname, "schema.graphql"), "utf8");

const football_api_options = {
    headers: {
        "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
        "x-rapidapi-key": secrets['API_FOOTBALL'],
        "useQueryString": true
    }
}

const resolvers = {
    Team: {
        name: (parent) => {
            return parent.team_name || parent.name;
        }
    },
    Standing: {
        latest_games: async (parent) => {
            const team_id: String = parent.team_id;
            const LIMIT_TO = 5;

            // Last 5 games of given team
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/team/${team_id}/last/${LIMIT_TO}`, football_api_options);
            const parsed = await response.json();

            // console.log(parsed.api.fixtures);
            return parsed.api.fixtures;
        },
        goal_averages: async (parent) => {
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/statistics/2/${parent.team_id}`, football_api_options);
            const parsed = await response.json();

            const goal_averages = parsed.api.statistics.goalsAvg;
            const goalsForAvgTotal = goal_averages.goalsFor.total;
            
            return goalsForAvgTotal;
        },
        goalie: async (parent) => {
            const team_id = parent.team_id; // TODO: get from parent
            const year = 2019;  // TODO: get from datetime
            
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/players/squad/${team_id}/${year}`, football_api_options)
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
        teams: async (_) => {
            const response = await fetch("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", football_api_options);
            const parsed = await response.json();
            return parsed.api.teams;
        },
        games: async (_) => {
            const league_id = 524;
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/league/${league_id}/last/10`, football_api_options);
            const parsed = await response.json();

            return parsed.api.fixtures;
        },
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
        compareTeams: async (_, { teamNames }) => {
            const league_id = 524;

            // GET team standings throughout league.
            const response = await fetch(`https://api-football-v1.p.rapidapi.com/v2/leagueTable/${league_id}`, football_api_options);
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