"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const { GraphQLServer } = require('graphql-yoga');
// Setup for API requests
const secrets = require("./secrets.json");
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
};
const resolvers = {
    Team: {
        name: (parent) => {
            return parent.team_name || parent.name;
        }
    },
    Player: {
        /** Grabs the url to the first image from Bing matching desired player headshot. */
        urlToImage: (parent) => __awaiter(void 0, void 0, void 0, function* () {
            const name = parent.player_name;
            const query = querystring.encode({
                count: "1",
                q: `${name} soccer headshot`
            });
            const baseURL = `https://bing-image-search1.p.rapidapi.com/images/search?${query}`;
            const response = yield fetch(baseURL, rapidapi);
            const parsed = yield response.json();
            return parsed.value[0].thumbnailUrl;
        })
    },
    Standing: {
        /** Get last 5 games of given team */
        latest_games: (parent) => __awaiter(void 0, void 0, void 0, function* () {
            const team_id = parent.team_id;
            const LIMIT_TO = 5;
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/team/${team_id}/last/${LIMIT_TO}`, rapidapi);
            const parsed = yield response.json();
            return parsed.api.fixtures;
        }),
        /** Get total goal average statistic of given team */
        goal_averages: (parent) => __awaiter(void 0, void 0, void 0, function* () {
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/statistics/2/${parent.team_id}`, rapidapi);
            const parsed = yield response.json();
            const goal_averages = parsed.api.statistics.goalsAvg;
            const goalsForAvgTotal = goal_averages.goalsFor.total;
            return goalsForAvgTotal;
        }),
        /** Get goalie of given team */
        goalie: (parent) => __awaiter(void 0, void 0, void 0, function* () {
            const team_id = parent.team_id;
            const year = 2019; // TODO: get from datetime
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/players/squad/${team_id}/${year}`, rapidapi);
            const parsed = yield response.json();
            const goalie = parsed.api.players.filter((player) => player.position == "Goalkeeper");
            return goalie[0] || null;
        })
    },
    GameResult: {
        score: (parent) => {
            return parent.score.fulltime;
        }
    },
    Query: {
        /** Gets all the teams in a particular league. */
        teams: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const league_id = 2;
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/teams/league/${league_id}`, rapidapi);
            const parsed = yield response.json();
            return parsed.api.teams;
        }),
        /** Gets last 10 games in league */
        games: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const league_id = 524;
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/league/${league_id}/last/10`, rapidapi);
            const parsed = yield response.json();
            return parsed.api.fixtures;
        }),
        /** Gets latest soccer news articles */
        notices: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const query = 'soccer';
            const response = yield fetch(`http://newsapi.org/v2/everything?q=${query}&` +
                'from=2020-09-08&' +
                'sortBy=popularity&' +
                `apiKey=${secrets["NEWS_API"]}`);
            const parsed = yield response.json();
            return parsed.articles;
        }),
        /** Query to compare the teams according to an array of team names passed in */
        compareTeams: (_, { teamNames }) => __awaiter(void 0, void 0, void 0, function* () {
            const league_id = 524; // TODO: Get league_id from teamName search
            // GET team standings throughout league.
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/leagueTable/${league_id}`, rapidapi);
            const parsed = yield response.json();
            // Filter to just the 2 teams requested
            const teamsToCompare = parsed.api.standings[0].filter((element, index, array) => {
                return teamNames.includes(element.teamName);
            });
            return teamsToCompare;
        })
    }
};
const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));
//# sourceMappingURL=index.js.map