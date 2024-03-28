# StatsBomb American Football Open Data

Welcome to the StatsBomb American Football Open Data repository.

StatsBomb are committed to sharing new data and research publicly to enhance understanding of the game of football. We want to actively encourage new research and analysis at all levels. Therefore we have made certain subsets of StatsBomb Data freely available for public use for research projects and genuine interest in football analytics.

StatsBomb are hoping that by making data freely available, we will extend the wider football analytics community and attract new talent to the industry.

## Terms & Conditions

If you publish, share or distribute any research, analysis or insights based on this data, please state the data source as StatsBomb and use our logo, available in our [Media Pack](https://statsbomb.com/media-pack/). Please see the [StatsBomb Public Data User Agreement](./LICENSE.pdf) for further information regarding use of the data.

## Getting Started

The [data](./data/) is provided as CSV, Parquet and compressed JSON files exported from the StatsBomb Data API, in the following structure:

* Play-level data stored in [`plays`](./data/plays/).
* Event-level data stored in [`events`](./data/events/).
* Low-frequency tracking data stored in [`lft`](./data/lft/). These can be accessed as:
    * Individual files for each game with file names referred to by their `game_id` i.e. `<GAME_ID>.csv` .
    * Individual files for each season as Parquet files.
* High-frequency tracking data stored in [`tracking`](./data/tracking/).
    * Individual files for each game with file names referred to by the date of the game and the teams playing. These are compressed `json` files with a `json.gz` file extension.
        * Meta-data and the `url` for each game can be found in the [`games.json`](./data/games.json) file.
    * Zipped `json` files containing the individual seasons, available via AWS S3:
        * [TB12DB 2016 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2016.zip)
        * [TB12DB 2017 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2017.zip)
        * [TB12DB 2018 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2018.zip)
        * [TB12DB 2019 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2019.zip)
        * [TB12DB 2020 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2020.zip)
        * [TB12DB 2021 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2021.zip)
        * [TB12DB 2022 season](https://statsbomb-amf-open-data.s3.eu-west-2.amazonaws.com/tracking/SB_tracking_TB12DB_2022.zip)

Some documentation about the meaning of different variables and the format of the files can be found in the [`doc`](./doc) directory.

### Examples
Examples of using the data can be found [here](./examples/).
* [`tb12_passes_python.ipynb`](./examples/tb12_passes_python.ipynb) - Python guide to load in the play and event data from the [#TB12DB](https://statsbomb.com/articles/football/the-tom-brady-data-biography/) release, perform some basic analysis and plot passes on a field. Google Colab version available [here](https://colab.research.google.com/drive/1yDlTc2i-ycyVf02OKJbEjTfrmN0wBPLR?usp=sharing).
* [`Tom Brady R Demo`](./examples/Tom_Brady_R_Demo.Rmd) - R guide to load in the play and event data from the [#TB12DB](https://statsbomb.com/articles/football/the-tom-brady-data-biography/) release, perform some basic analysis and create a scatter plot and field plot of the data. Google Colab version available [here](https://colab.research.google.com/drive/1IwZ9T9FC0G1M-5zfVuf8d8Ax_8a56WLl?usp=sharing).
* [`tb12_tracking_python.ipynb`](./examples/tb12_tracking_python.ipynb) - Python guide to load in a game of tracking data from the [#TB12DB](https://statsbomb.com/articles/football/the-tom-brady-data-biography/) release and create an animation of an individual play. Google Colab version available [here](https://colab.research.google.com/drive/1TNvvbyvrdpK38bB6UrhA4xZhU0fkNrdi?usp=sharing).
* [`tb12 tracking R Demo`](./examples/TB12DB_tracking_parsing.R) - R guide to load in a game of tracking data from the [#TB12DB](https://statsbomb.com/articles/football/the-tom-brady-data-biography/) release and create an animation of an individual play.
* [`tb12_tracking_defense_python.ipynb`](./examples/tb12_tracking_defense_python.ipynb) - Python guide to load in multiple games of tracking data from the [#TB12DB](https://statsbomb.com/articles/football/the-tom-brady-data-biography/) release and automatically detect defensive alignments. Google Colab version available [here](https://colab.research.google.com/drive/1bawNWRVrGyN7iLtzf4Owj_wceKQ3NI-g?usp=sharing).

## Careers

If you're interested in football data, [StatsBomb is always hiring!](https://statsbomb.bamboohr.com/jobs/)