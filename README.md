docker-groovebasin
==================

Groove Basin dockerization.

This is a fork from [morvans/docker-groovebasin](https://github.com/morvans/docker-groovebasin) with a few slight changes:

* I'm using Stackbrew/Ubuntu instead of the default Ubuntu
* Groove Basin is installed from NPM, currently version 1.0.1
* Supervisord is eliminated, Groove Basin is just run directly
* Groove Basin is run as an unprivileged user.
* A volume for storing Groove Basin's database, etc is added

## Usage

You'll need a music folder, and a folder for Groove Basin to store its database.

Right now, I've just been running this with the `--privileged` flag, in order
to use the system's sound. The original project uses the `--lxc-conf` switch
but I can't seem to get that to work.

### Build

```
$ git clone https://github.com/jprjr/docker-groovebasin.git
$ cd docker-groovebasin
$ docker build -t jprjr/groovebasin .
```

### Run in foreground
```
$ docker run -v /dev/snd:/dev/snd:rw -v /path/to/music:/music -v /path/to/groove:/groove --privileged -p 6600:6600 -p 16242:16242 jprjr/groovebasin 
```

### Run in background
```
$ docker run -d -v /dev/snd:/dev/snd:rw -v /path/to/music:/music -v /path/to/groove:/groove --privileged -p 6600:6600 -p 16242:16242 jprjr/groovebasin 
```

Alternatively, you should be able to use links and data-only containers for
persistence.

## Exposed ports

* 6600 (MPD port)
* 16242 (Web Interface)

## Exposed volumes

* `/music` 
* `/groove` 
