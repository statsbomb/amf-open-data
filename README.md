# StatsBomb American Football Open Data

Welcome to the StatsBomb American Football Open Data repository.

StatsBomb are committed to sharing new data and research publicly to enhance understanding of the game of football. We want to actively encourage new research and analysis at all levels. Therefore we have made certain subsets of StatsBomb Data freely available for public use for research projects and genuine interest in football analytics.

StatsBomb are hoping that by making data freely available, we will extend the wider football analytics community and attract new talent to the industry.

## Terms & Conditions

If you publish, share or distribute any research, analysis or insights based on this data, please state the data source as StatsBomb and use our logo, available in our [Media Pack](https://statsbomb.com/media-pack/). Please see the [StatsBomb Public Data User Agreement](./LICENSE.pdf) for further information regarding use of the data.

## Getting Started

The [data](./data/) is provided as CSV files exported from the StatsBomb Data API, in the following structure:

* Play-level data stored in [`plays`](./data/plays/).
* Event-level data stored in [`events`](./data/events/).
* Frame-level data stored in [`frames`](./data/frames/). These can be accessed as individual files for each game with file names referred to by their `game_id` i.e. `lft_<GAME_ID>.csv` .

Some documentation about the meaning of different variables and the format of the files can be found in the [`doc`](./doc) directory.

Examples of using the data can be found [here](./examples/).

## Careers

If you're interested in football data, [StatsBomb is always hiring!](https://statsbomb.bamboohr.com/jobs/)
