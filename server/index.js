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
const secrets = require("./secrets.json");
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
};
const newsAPI = {
    key: '18dcef7737a7410b846396edb9dc9fa2'
};
const resolvers = {
    Team: {
        name: (parent) => {
            return parent.team_name;
        }
    },
    Query: {
        teams: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const response = yield fetch("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", football_api_options);
            const parsed = yield response.json();
            return parsed.api.teams;
        }),
        games: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const league_id = 524;
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/league/${league_id}/last/10`, football_api_options);
            const parsed = yield response.json();
            return parsed.api.fixtures;
        }),
        notices: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const query = 'soccer';
            const response = yield fetch(`http://newsapi.org/v2/everything?q=${query}&` +
                'from=2020-09-08&' +
                'sortBy=popularity&' +
                `apiKey=${secrets["NEWS_API"]}`);
            const parsed = yield response.json();
            return parsed.articles;
        })
    }
};
const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));
//# sourceMappingURL=index.js.map