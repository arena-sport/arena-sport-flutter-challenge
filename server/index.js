const { GraphQLServer } = require('graphql-yoga');
const fetch = require('node-fetch');

const options = {
    headers: {
        "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
	    "x-rapidapi-key": "321c545a2amshe07deeb6f221be6p1bf2a3jsnd3aafcc969bf",
        "useQueryString": true
    }
}

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
        gameDate: String
    }

    type Notice {
        title: String
    }
`;

const resolvers = {
    Query: {
        id: (_) => {
            return 24;
        },
        teams: async (_) => {
            const response = await fetch("https://api-football-v1.p.rapidapi.com/v2/teams/league/2", options);
            const parsed = await response.json();
            
            return parsed.api.teams;
        }
    }
}

const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));