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
const fetch = require('node-fetch');
const options = {
    headers: {
        "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
        "x-rapidapi-key": "321c545a2amshe07deeb6f221be6p1bf2a3jsnd3aafcc969bf",
        "useQueryString": true
    }
};
const typeDefs = `
    type Query {
        teams: [Team]
        games: [Game]
        notices: [Notice],
        id: Int,
    }

    type Team {
        team_id: Int
        name: String
        logo: String
    }

    type Game {
        event_date: String
        homeTeam: Team
        awayTeam: Team
        goalsHomeTeam: Int
        goalsAwayTeam: Int
    }

    type Notice {
        title: String
    }
`;
const resolvers = {
    // Game: {
    //     homeTeam: (parent) => {
    //         console.log('fksjfksaj');
    //         //console.log(parent);
    //     }
    // },
    Query: {
        id: (_) => {
            return 24;
        },
        teams: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const response = yield fetch("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", options);
            const parsed = yield response.json();
            return parsed.api.teams;
        }),
        games: (_) => __awaiter(void 0, void 0, void 0, function* () {
            const league_id = 524;
            const response = yield fetch(`https://api-football-v1.p.rapidapi.com/v2/fixtures/league/${league_id}/last/10`, options);
            const parsed = yield response.json();
            return parsed.api.fixtures;
        })
    }
};
const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));
//# sourceMappingURL=index.js.map