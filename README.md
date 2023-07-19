# Fluttercode
Project
```mermaid
graph TD;
  PublicRepo -- contains --> PublicGameData;
  PrivateRepo -- contains --> PrivateGameData;
  PrivateRepo -->|daily copy| PublicRepo;
  GithubAction -->|triggers| PrivateRepo;
  GithubAction -->|pushes data to| PublicRepo;
  GameDownload -->|accesses| PublicRepo;
  PublicRepo -- allows --> GameDownload;
```
prompt
```
use mermaid to draw a diagram for below,
a public github repository holds public game data
a private github repository holds private game data
a github action execute daily, which copy game date from private repository to public repository
a game download public game data from public repository
```
