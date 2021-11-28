# Postgis

## Hasura CLI

Install hasura cli.

```bash
curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
hasura version
```

Initialize.

```bash
hasura init hasura-data --endpoint http://localhost:8080
```

Run hasura.

```bash
docker compose up
```

Update metadata.

```bash
cd hasura-data
hasura metadata export
```
