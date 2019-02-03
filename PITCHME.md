---

<span style="font-weight: bold; font-size: 150%; color:#FFFF00">Going Places with Your Container(s)</span>

February 8, 2019
#### Tyson Lee Swetnam
[CyVerse](http://cyverse.org/)

+++

### My Contact Info

email: tswetnam@cyverse.org

github id: [tyson-swetnam](https://github.com/tyson-swetnam) & [cyverse-gis](https://github.com/cyverse-gis)

twitter: tswetnam

---

### Today's Roadmap


<span style="font-size: 80%; color:#FF0000">Review: "Make Your Life (and Analyses) Easier with Containers, Julian Pistorius" </span> <!-- .element: class="fragment" -->

<span style="font-size: 100%; color:#FF0000">Building your own container</span> <!-- .element: class="fragment" -->

<span style="font-size: 100%; color:#FF0000">Have Container(s), Will travel </span> <!-- .element: class="fragment" -->

---

### Two weeks ago: [Make your life and analyses easier with Containers](https://github.com/julianpistorius/presentation-containers-intro)

#### Presented by Julian Pistorius

+++   

## Pitfalls when working in bespoke software and environments

+++

*different OS + third party software + updates/upgrades + redeployment* = <span style="font-weight: bold; font-size: 100%; color:#FF0000">_Dependency Hell_</span> <!-- .element: class="fragment" -->
 
<img src="https://imgs.xkcd.com/comics/python_environment_2x.png" height="400"> <!-- .element: class="fragment" --> <img src="https://pbs.twimg.com/media/DB6QcoNVYAA-w6N.jpg" height="400"> <!-- .element: class="fragment" -->

+++

## Solution: Containerize the software, run it anywhere. 

<img src="https://cdn-images-1.medium.com/max/1600/1*yo62B91F4V1QIJYirBbxlQ.jpeg" width="400"> <!-- .element: class="fragment" -->

+++

## Why Containerize?

- Dependencies turn into wicked problems <!-- .element: class="fragment" -->
- Compiling software is sloooowww <!-- .element: class="fragment" -->
- Reproducability is hard across platforms <!-- .element: class="fragment" -->
- Portability <!-- .element: class="fragment" --> **& _Scalability_** <!-- .element: class="fragment" -->


## Which software should you use?

+++
### DOCKER
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Docker_%28container_engine%29_logo.svg/2000px-Docker_%28container_engine%29_logo.svg.png" width="800">

### Singularity
<img src="https://www.sylabs.io/wp-content/uploads/2018/10/s-icon.png" height="200">

+++

## Picking the container that is right for you

- <span style="font-weight: bold; font-size: 80%; color:#55FF33">Find one that already exists on https://hub.docker.com/<!-- .element: class="fragment" --> 
-  <span style="font-weight: bold; font-size: 80%; color:#F9FF33">Modify an existing container by adding new dependencies<!-- .element: class="fragment" --> 
-  <span style="font-weight: bold; font-size: 80%; color:#FF0000">Create your own from scratch<!-- .element: class="fragment" --> 

+++

**Beware of the Turing Tarpit** 

Alan Perlis, 1982 Epigrams on Programming

<span style="font-weight: bold; font-size: 80%; color:#FF0000">_In which everything is possible but nothing of interest is easy_</span> <!-- .element: class="fragment" -->

<img src="https://img00.deviantart.net/58af/i/2012/093/a/c/la_brea_tar_pits_by_felipenn-d4uxy05.jpg" width="400">

+++

## Data scientists need places to work...

<img src="https://21stcenturyrenaissanceprintmaker.files.wordpress.com/2014/04/nova-reperta-with-letters.png" height="400">

+++

### A data science environment allows you to: 

- Work in a favored environment & language 
- Tools and libraries you like to use
- Computational notebooks 
  - Python, R, C++, Matlab, Spark, etc. 
  
+++

## <span style="color: #e49436">Create a Dockerfile</span>
<br>

```shell
FROM ubuntu:18.04
MAINTAINER "Tyson Lee Swetnam" tswetnam@cyverse.org
RUN apt-get update && apt-get install -y fortune cowsay lolcat
ENV PATH /usr/games:${PATH}
ENV LC_ALL=C
ENTRYPOINT fortune | cowsay | lolcat

```

@[1](FROM a image base, e.g. alpine, centos, debian, ubuntu, I use Ubuntu Bionic Beaver 18.04)
@[2](Add in who the person was who created the container - not required)
@[3](RUN a set of scripts, here an update and installation of three programs)
@[4](Set the environment, adding the three new games to the PATH)
@[5](Use the default language)
@[6](the ENTRYPOINT is what will happen when the container is run)

+++

@title[DOCKER]

## <span style="color: #e49436">Build your Docker container</span>
<br>


```shell
$ sudo docker build -t tswetnam/cowsay:latest .
$ docker run -it tswetnam/cowsay:latest 
$ docker run --rm -it --entrypoint /bin/bash tswetnam/cowsay:latest 
$ fortune | cowsay | lolcat
$ docker push tswetnam/cowsay:latest

Done!
```

@[1](Use `sudo` to build the image with a tag name)
@[2](Run new image using the interactive and TTY flags)
@[3](Start a bash shell inside the container - note: you're inside the container now)
@[4](Run the programs from inside the container)
@[5](Push your container to DockerHub)
@[7](Done!)

+++

## Containers for HPC

[Singularity](http://singularity.lbl.gov)

<img src="https://www.sylabs.io/wp-content/uploads/2018/10/s-icon.png" height="200">

+++

- Shares the host environment
  - See linux host file system
  - add mounted volumes
- Your same username and `root` privileges inside container
  - install your own software on HPC!
- Build your own images or use an existing Docker container

+++

## <span style="color: #e49436">Writing a Singularity file</span>
<br>

```shell
BootStrap: docker
From: ubuntu:18.04

%help
  "This container tells a joke" 
%post
  apt-get -y update
  apt-get -y install fortune cowsay lolcat
%environment
  export LC_ALL=C
  export PATH=/usr/games:$PATH
%runscript
  fortune | cowsay | lolcat
```

@[1](Select an image repository - could be `docker`, `shub`, or `yum`)
@[2](Image hosted on Docker Hub - Ubuntu Bionic Beaver 18.04)
@[4,5](`%help` is a simple help text)
@[6,7,8](`%post` command runs Bash commands like `apt-get` to install dependencies or programs)
@[9,10,11](`%environment` settings, exporting paths for where to look for the commands)
@[12,13](`%runscript` execute scripts in the container)

+++

@title[Singularity]

## <span style="color: #e49436">Build your Singularity Image</span>
<br>

```shell
$ sudo singularity build cowsay.simg Singularity
$ singularity run cowsay.simg
$ singularity exec cowsay.simg fortune | cowsay | lolcat
$ singularity shell cowsay.simg
$ fortune | cowsay | lolcat
$ singularity run docker://tswetnam/cowsay:latest

Done!
```

@[1](Use `sudo` to build the image with your Singularity file)
@[2](Run new image)
@[3](Execute the programs in the container)
@[4](Start a bash shell inside the container - note: you're inside the container now)
@[5](Run the programs)
@[6](Pull the Docker version of the container and run it with Singularity!)
@[8](Done!)

+++

+++

## Installing Popular Container software on CyVerse Atmosphere

+++

@title[EZ Install]

## <span style="color: #e49436">EZ Install</span>
<br>

```shell
$ ez
$ ezd
$ ezs
$ ezj -R -3
$ ezjh
```

@[1](View option menu for Ansible `ez`)
@[2](Install latest version of Docker)
@[3](Install latest version of Singularity)
@[4](Install Anaconda and Jupyter Notebooks w/ Python3 and the R Kernel)
@[5](Install Jupyter-Hub with CyVerse CAS)

+++


+++

## Building the "best" containers takes time

<img src="https://consequenceofsound.files.wordpress.com/2016/04/screen-shot-2016-04-08-at-10-33-51-am.png" width="500">

+++

---

## Have Container(s), Will Travel

<img src="https://rhystranter.files.wordpress.com/2016/11/studio-ghibli-howls-moving-castle.jpg" height="400">

---


## Skill levels

+++

<span style="font-weight: bold; font-size: 150%; color:#FF0000">New users</span>

- Interest in Graphic User Interfaces (GUI) & Integrated Development Environment (IDE) tools <!-- .element: class="fragment" -->
  
- Maybe just learning spatial analyses for the first time <!-- .element: class="fragment" -->

+++

<span style="font-weight: bold; font-size: 150%; color:#F0FF00">Experienced users</span>

- Interest in scaling workflows beyond the laptop / desktop on to HPC and Cloud <!-- .element: class="fragment" -->

- Need to move significant amounts of data around networks <!-- .element: class="fragment" -->

+++

<span style="font-weight: bold; font-size: 150%; color:#FFAA00">Power users</span>

- Interest in integrating global and national datasets across HPC environments for massively parallel computing <!-- .element: class="fragment" -->

---

### What does <span style="font-weight: bold; color: #118224">large-scale</span> really mean in the era of <span style="color: #3685E3">_big data_</span>?

+++

<span style="font-size: 150%; color:#ffffff">Data are always increasing in volume</span>

+++

<span style="font-weight: bold; font-size: 150%; color:#FF0000">90% </span><span style="font-size: 150%; color: #ffffff"> of all data in human history were created in the [last 24 months](https://blog.microfocus.com/how-much-data-is-created-on-the-internet-each-day/)</span>

+++

<span style="font-size: 150%; color:#ffffff">So, what qualifies as big data?</span>

@[0](<span style="font-size: 250%; font-weight: bold; color:#3685E3">Megabyte 10<sup><span style="font-size: 75%; font-weight: bold; color:#3685E3">6</span></sup>?</span>)
@[1](<span style="font-size: 250%; font-weight: bold; color:#0000FF">Gigabyte 10<sup><span style="font-size: 75%; font-weight: bold; color:#0000FF">9</span></sup>?</span>)
@[2](<span style="font-size: 250%; font-weight: bold; color:#0000A0">Terabyte 10<sup><span style="font-size: 75%; font-weight: bold; color:#0000A0">12</span></sup>?</span>)
@[3](<span style="font-size: 250%; font-weight: bold; color:#800080">Petabyte 10<sup><span style="font-size: 75%; font-weight: bold; color:#800080">15</span></sup>?</span>)
@[4](<span style="font-size: 250%; font-weight: bold; color:#00FF00">Exabyte 10<sup><span style="font-size: 75%; font-weight: bold; color:#00FF00">18</span></sup>?</span>)
@[5](<span style="font-size: 300%; font-weight: bold; color:#FF0000">data are just data</span>)

+++

Computing power and storage capacity are advancing at exponential rate

+++?image=assets/imagery/Moores_Law_over_120_Years.png&size=contain

<span style="color:#3685E3"> last 5 are all GPUs </span> 

---

## The Research Object

+++

<span style="font-size: 150%; color:#ffffff">Okay, what is a [Research Object](http://www.researchobject.org/)?</span>

@[1](<span style="font-size: 150%; font-weight: bold; color:#3685E3">broadly, it is a method for identification, aggregation, and exchange of scholarly information</span>)

+++
"_Supporting the publication of *more than just PDFs*, making *data*, *code*, and other resources *first class citizens of scholarship*_"

[Research Objects](http://www.researchobject.org/) have:

- Digital identity: DOI, <!-- .element: class="fragment" --> [ORCID](http://orcid.org/) <!-- .element: class="fragment" -->

- Annotation & Provenance <!-- .element: class="fragment" --> *METADATA!* <!-- .element: class="fragment" -->

Most importantly: they are discoverable & reusable <!-- .element: class="fragment" -->

+++

CyVerse covers the entire life cycle of the Research Object:

- Create
- Analyze
- Annotate
- Publish
- Archive

+++

## Popular Data Science Software

+++

<img src="assets/imagery/Python_logo_and_wordmark.svg.png" height="150"> <img src="http://jupyter.org/assets/hublogo.svg" height="150">
<img src="http://mybinder.org/assets/images/logo.svg" height="150">

+++

<img src="assets/imagery/Rlogonew.png" height="150"> <img src="https://www.rstudio.com/wp-content/uploads/2014/07/RStudio-Logo-Blue-Gradient.png" height="150">

---

## What is [CyVerse](http://cyverse.org)? 
![cyverse](assets/imagery/cyverse_logo_150px.png)

+++

Started 2008 as iPlant Collaborative, renewed 2013 by NSF, rebranded 2016

<img src="https://www2.cs.arizona.edu/news/articles/images/200801-iplant.jpg" height="100"> <img src="http://blog.illumina.com/img/iplant.jpg" height="100"> <img src="http://www.cyverse.org/sites/default/files/cyverse_rgb.png" height="100">

+++

<span style="font-weight: bold; color:#3685E3">Vision:</span> Transforming science through data driven discovery.</span>

+++

<span style="font-weight: bold; color: #3685E3">Mission:</span> To design, deploy, and expand a national cyberinfrastructure for life sciences research, and to train scientists in its use.</span>

+++

### CyVerse is enabled by <span style="font-weight: bold; color: #c7232e">_people & research_</span>  <!-- .element: class="fragment" -->

### CyVerse' success depends on users innovating within an ecosystem of interoperability  <!-- .element: class="fragment" -->

+++

<img src="http://www.twincities.com/wp-content/uploads/2015/11/20130102__field-of-dreamsl.jpg" height="250"> <img src="https://theamericangenius.com/wp-content/uploads/2014/02/field-of-dreams.jpg" height="250">

<span style="font-weight: bold; font-size: 150%; color:#FF0000">NOT!</span> <!-- .element: class="fragment" -->

+++

### When scientists begin using CyVerse <span style="font-weight: bold; color: #3685E3">we</span> work together to develop your tools, workflows, and datasets

<img src="http://insidethegem.com/wp-content/uploads/organic-logo.png" height="150"> <img src="http://cstaab.com/wp-content/uploads/cpp_java_python.png" height="150"> <img src="https://pbs.twimg.com/profile_images/662507863516905472/7piKPHHv_400x400.jpg" height="150"> 

---

### What does CyVerse offer for you to work with containers?

<img src="https://upload.wikimedia.org/wikipedia/commons/6/65/Scholars_attending_a_lecture_in_the_Ashmolean_Museum%2C_Oxford_Wellcome_V0006732.jpg" height="600">

---

## [Atmosphere](https://cyverse.org/atmosphere)
![atmo](assets/imagery/Atmosphere_Blue.png)

+++

## On demand cloud computing for scientific research

+++

- Linux environment (Centos, Ubuntu)
- Collaborate together online
- Publically host custom images

+++

- Multiple instance sizes and 'flavors'
  - 1 CPU, 4GB RAM, 30GB Disk
  up to 
  - 16 CPU, 128GB RAM, 1400GB Disk
- Attach (and swap) external storage volumes    
- emulated web shell and desktop via [Apache _Guacamole_](https://guacamole.incubator.apache.org/)  

+++

## Atmosphere proved to be very popular...

+++

## ... and so they built

<img src="assets/imagery/Jetstream_logo_hi_res_cropped.jpg" width="600">

+++?image=/assets/imagery/Jetstream_topology_diagram-crop.png&size=95%

- a research scale cloud running Atmosphere
- instance sizes from 1 core 2GB RAM, up to 44 CPU, 120GB RAM

+++

## [Discovery Environment](https://de.cyverse.org)
![de](assets/imagery/Discovery_blue.png)

+++

<img src="http://www.cyverse.org/sites/default/files/DE-website-Mar2015.png" width="400">

- Easily add any command-line tool or any executable into the tool list
- create or edit a new customized interface or create a sequenced workflow by chaining one app to another in automated workflow.
- Use application programming interfaces (APIs)

+++

Bring your own tools to the Discovery Environment

<img src="https://f1000researchdata.s3.amazonaws.com/manuscripts/9614/e8fc9784-bed0-46bd-abc4-e070165a0c78_figure2.gif" height="400">

[Devisetty et al. 2016](https://f1000research.com/articles/5-1442/v1)


---

## [Learning Center](http://learning.cyverse.org/en/latest/) 
![lc](assets/imagery/Learningcenter_blue.png)

+++

## Container Camp

March 6-8, 2019
Location: University of Arizona, Tucson AZ
https://www.cyverse.org/cc

+++

## Foundational Open Science Skills (FOSS)

June 3–14, 2019
Location: University of Arizona, Tucson AZ
https://www.cyverse.org/foss

<img src="https://static.wixstatic.com/media/1f832b_cbc41b96ceab44298f7522fa7ad9b7fe~mv2.jpg" width="800">

+++

## Setting up Atmosphere instances as Data Science Workbenches

+++

<img src="assets/imagery/RStudio-Logo-Blue-Gradient.png" width="500">

+++

@title[Docker RStudio]

## <span style="color: #e49436">Docker + RStudio</span>
<br>

```shell
$ ezd
$ sudo usermod -aG docker $USER
$ exit
$ docker pull rocker/geospatial:latest
$ docker run --rm -d -p 8787:8787 -e PASSWORD=password rocker/geospatial:latest

Done!

```

@[1](install Docker)
@[2](change `sudo` privileges)
@[3](exit and restart terminal window)
@[4](pull the Rocker/Geospatial Rstudio-Server from DockerHub)
@[5](Run the Container in detached mode `-d` on port `-p 8787:8787`)
@[7](Open the Instance's IP address w/ port number in a new browser window)


<img src="assets/imagery/vertical_large.png" height="200"> <img src="https://secure.gravatar.com/avatar/eebe55e8aac8144c9a0e2e1cac5d9057.jpg" height="200">

+++

## Multi-container jobs with Makeflow

+++

How do I scale my research to use hundreds to thousands of computers?
<img src="https://raw.githubusercontent.com/cooperative-computing-lab/makeflow-examples/master/banner.png" width="800">

+++?image=assets/imagery/eemt_github.PNG&size=auto 95%

+++?image=assets/imagery/eemt_singularity.png.png&size=auto 95%

---

## Where to get started, if you don't know where to start?

[The Carpentries](https://software-carpentry.org/)

[http://learning.cyverse.org/](http://learning.cyverse.org/)

---

<img src="assets/imagery/cyverse_logo_150px.png" width="150">

### CyVerse is supported by the National Science Foundation under Grants No. DBI-0735191, DBI-1265383, & DBI-1743442.

<img src="assets/imagery/nsf_logo.png" height="75"> 
<img src="assets/imagery/az.png" height="75"> 
<img src="assets/imagery/tacc.png" height="75"> 
<img src="assets/imagery/cshl.png" height="75"> 
<img src="assets/imagery/uncw.gif" height="75">
