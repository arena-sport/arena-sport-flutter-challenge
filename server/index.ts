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

const newsAPI = {
    key: '18dcef7737a7410b846396edb9dc9fa2'
}

const resolvers = {
    Team: {
        name: (parent) => {
            return parent.team_name;
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
        }
    }
}

const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));