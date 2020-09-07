const { GraphQLServer } = require('graphql-yoga');
const fetch = require('node-fetch');

const typeDefs = `
    type Query {
        hello(name: String): String!
        getPerson(id: Int!): Person
    }

    type Film {
        title: String,
        episode_id: String,
    }

    type Person {
        name: String
        height: String
        mass: Int
        hair_color: String
        skin_color: String,
        films: [Film],
    }
`;

const resolvers = {
    Person: {
        films: (person) => {
            const filmsPromises = person.films.map(async url => {
                const response = await fetch(url);
                return response.json();
            });

            return Promise.all(filmsPromises);
        }
    },
    Query: {
        hello: (_, { name }) => { return `Hello ${name || 'World'}` },
        getPerson: async (_, { id }) => {
            const response = await fetch(`https://swapi.dev/api/people/${id}/`);
            return response.json();
        }
    }
}

const server = new GraphQLServer({ typeDefs, resolvers });
server.start(() => console.log('Server is running on localhost:4000'));