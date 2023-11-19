# Music Bot

A complete example of a discord music bot including database, web dashboard, and more powered by [discord.js](https://discord.js.org/#/) and [discord-player](https://discord-player.js.org).

## Setup

- Run `pnpm install --frozen-lockfile` to install all dependencies
- Rename `.env.example` to `.env` and fill out the values
  - Put your bot token in `DISCORD_TOKEN`
  - Put mongodb database credentials in `DATABASE_URL` (You can get one for free from [Mongodb Atlas](https://www.mongodb.com/atlas))
  - Put your redis config in `REDIS_*` (you can use memurai for windows)
- Run `pnpm run bot` to start the bot in development mode

![Alt text](https://raw.githubusercontent.com/twlite/music-bot/main/assets/preview.png?raw=true 'Preview')
