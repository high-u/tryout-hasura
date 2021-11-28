# Postgis

## Hasura CLI

### Install hasura cli

```bash
curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
hasura version
```

### Initialize

```bash
hasura init hasura-data --endpoint http://localhost:8080
```

### Update metadata

```bash
cd hasura-data
hasura metadata export
```

## Boot up hasura

```bash
docker compose up -d
```

## GraphQL Query

### Example

Query

```graphql
query landmarksIncludedInCircle(
  $latitude: float8 = "",
  $longitude: float8 = "",
  $radius: Int = 100
) {
  landmarks: geo_landmarks(args: {
    latitude: $latitude,
    longitude: $longitude,
    radius: $radius
  }) {
    id
    name
    location
  }
}
```

Variables

```json
{
  "latitude": 35.65867828258049,
  "longitude": 139.7454000428654,
  "radius": 500
}
```
