// graphql.config.js
module.exports = {
    schema: ["src/schema.graphql", "my/directives.graphql"],
    documents: ["**/*.{graphql,js,ts,jsx,tsx}", "my/fragments.graphql"],
    extensions: {
      endpoints: {
        default: {
          url: "http://localhost:8000",
          headers: { Authorization: `Bearer ${process.env.API_TOKEN}` },
        },
      },
    },
    projects: {
      db: {
        schema: "src/generated/db.graphql",
        documents: ["src/db/**/*.graphql", "my/fragments.graphql"],
        extensions: {
          codegen: [
            {
              generator: "graphql-binding",
              language: "typescript",
              output: {
                binding: "src/generated/db.ts",
              },
            },
          ],
        },
      },
    },
  }