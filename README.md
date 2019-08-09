![FastTracks Screenshot](/fast_tracks_screenshot.png?raw=true "FastTracks Screenshot")

# FastTracks

## About

Welcome to _FastTracks_! This is a [Turing School of Software & Design](https://turing.io) project completed by [Brennan Ayers](https://github.com/BrennanAyers), [Rob Stringer](https://github.com/Mycobee), [William Homer](https://github.com/WHomer) and [Alexander Mathieu](https://github.com/alexander-mathieu).

FastTracks combines data from Strava and Spotify to deliver insights and music recommendations based on performance. Once users sync both their Strava and Spotify accounts, new activities are posted to FastTracks via a Strava webhook. The Spotify API is then queried to determined which songs where played during that activity, and matched to data from Strava to figure out the user's level of exertion during that song. All information is then averaged into a final 'power ranking' for each song, displayed to the user on the dashboard.

FastTracks also provides musical recommendations based on the user's songs with the highest power rankings, and allows the user to create a new Spotify playlist or add to an existing one.

The deployed site can be viewed [here](https://rocky-springs-29283.herokuapp.com).

## Local Installation

### Requirements
 * [Redis](https://redis.io/topics/quickstart)
 * [Rails 5.2.3](https://rubyonrails.org) - Rails Version
 * [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads) - Ruby Version

### Repository Setup

```
$ git clone https://github.com/alexander-mathieu/fast_tracks.git
$ cd fast_tracks
$ bundle install
```

### Database Setup

```
$ rake db:{drop,create,migrate,seed}
```

### Micro-service Setup

Local setup requires the installation of the FastTracks Flask micro-service. Setup instructions can be found [here](https://github.com/BrennanAyers/flask_tracks).

## Schema

![Rales Engine Schema](/fast_tracks_schema.png?raw=true 'FastTracks Schema')

## Running Tests

The model and feature tests can be run using `rspec`.

Example of expected output:
```
....................................

Finished in 2.08 seconds (files took 4.37 seconds to load)
36 examples, 0 failures

Coverage report generated for RSpec to /Users/alexandermathieu/turing/mod_3/projects/fast_tracks/coverage. 648 / 655 LOC (98.93%) covered.
```

## Initial Project Requirements

Information about initial project requirements can be found [here](https://backend.turing.io/module3/projects/terrificus).
