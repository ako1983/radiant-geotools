# Radiant Earth Foundation GeoTools

A docker image and jupyter notebook to conduct geospatial analysis using Radiant's platform. 

## Usage

### UNIX systems:

```
docker run -it --name refgeotool -p 8888:8888 -v /path_to_data:/workdir/data radiantearth/geotools bash
```

If you need to get the path to the folder where you have the data, navigate to the folder and use:

```
pwd
```

For example if you want to access imagery in a folder called `data` within your `Documents/`, an example path, assuming your name is Susan, might look like:

```
/Users/Susan/Documents/data
```

Thus, the entire docker run command in this case would be:

```
docker run -it --name refgeotool -p 8888:8888 -v /Users/Susan/Documents/data:/workdir/data radiantearth/geotools bash
```

### Windows systems:


```
docker run -it --name refgeotool -p 8888:8888 -v /path_to_data:/workdir/data radiantearth/geotools bash
```

If you need to get the path to the folder where you have the data, navigate to the folder and use:

```
cd
```

For example if you want to access imagery in a folder called `data` within your `Documents\`, an example path, assuming your name is Bill (but your username is bill, lowecase - this is also true for UNIX systems), might look like:

```
C:\Users\bill\Documents\data
```

Thus, the entire docker run command in this case would be:

```
docker run -it --name refgeotool -p 8888:8888 -v C:\Users\bill\Documents\data:/workdir/data radiantearth/geotools bash
```