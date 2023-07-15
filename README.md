# Fluttercode
Project
```mermaid
graph TD;
  PublicRepo -- contains --> PublicGameData;
  PrivateRepo -- contains --> PrivateGameData;
  PrivateRepo -->|daily copy| PublicRepo;
  GithubAction -->|triggers| PrivateRepo;
  GithubAction -->|pushes data to| PublicRepo;
```
prompt
```
use mermaid to draw a diagram for below,
a public github repository holds public game data
a private github repository holds private game data
a github action execute daily copy game of the date from private repository to public repository
```
