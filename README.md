# pm25

![screenshot](https://raw.githubusercontent.com/wzc314/pm25/master/screenshot.png)

## What is it?

* This is an Elixir application which aims to inquiry PM2.5 conveniently.
* Framework of the application is based on [tacticiankerala/elixir-weather](https://github.com/tacticiankerala/elixir-weather).
* Notice that only cities in China are supported now.
* Virtually, the output value of command is Air Quality Index(AQI) which will update every hour, but not PM2.5 :)

## Installation

1. Be sure you have installed Erlang before running this application, and installing Elixir is optional. [Here](http://elixir-lang.org/install.html#installing-erlang) is how to install Erlang.
2. Clone this repository: `git clone https://github.com/wzc314/pm25.git ~/elixir-pm25`
3. Change directory to the repository: `cd ~/elixir-pm25`
4. Run the command by giving a city name(Chinese character supported only): `./pm25 <city name>`
