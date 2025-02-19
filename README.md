``` 
          _      __                 __                                     __  
   ____  (_)____/ /_   ____ ___  __/ /_____     ________  ____ ___________/ /_ 
  / __ \/ / ___/ __/  / __ `/ / / / __/ __ \   / ___/ _ \/ __ `/ ___/ ___/ __ \
 / / / / (__  ) /_   / /_/ / /_/ / /_/ /_/ /  (__  )  __/ /_/ / /  / /__/ / / /
/_/ /_/_/____/\__/   \__,_/\__,_/\__/\____/  /____/\___/\__,_/_/   \___/_/ /_/ 
                                                                               
```                                                                         

# nistAutoSearch

This repository provides tools to perform library searches against electron ionization mass spectral (EI-MS) databases using the API provided by [NIST MS Search](https://chemdata.nist.gov/mass-spc/ms-search/downloads/) software. It includes R scripts for:



1. Automating spectral library searches.
2. Processing mass spectral data in MSP (NIST) format.
3. Handling large datasets by splitting lists into manageable blocks.
4. Automatic MSP (NIST) file itergrity fix.
5. Exporting search results and processed data to CSV files.
6. Automatic installation all dependencies.
 
## How to run the tool
### Run the Tool

1. Start the tool by running the `launcher.bat` file.
2. Make sure the NIST MS Search program is installed in its deafult location (`C:\NIST$\MSSEARCH`) and running.
3. NIST MS Search must be open and ready to communicate with its API.
4. Make sure the launcher can locate the R engine. You need to specify the path to the R executable in the `launcher.bat` file. Update the following line if you have an alterantive path:

```batch
rem path to R.exe folder
set "R_location=C:\Program Files"
```

### Enable Automatic Search

1. In NIST MS Search, navigate to `Options` -> `Library Search Options` menu -> `Automation` tab.
2. Enable `Automatic Search On` to allow the tool to communicate with the NIST MS Search API.

### Set the Number of Hits to Print

1. In the `Automation` tab of the `Library Search options`, find the `Number of hits to print` field.
2. Adjust this value to control how many search results are displayed for each query.
3. Let the tool perform the analysis of your input MSP (NIST) data automatically.

Once configured, the tool will automate spectral library searches, process your mass spectral data, and export results as needed.

### Output csv table:

| rda name | name      | mf           | rmf          | prob       | lib     | cas       | formula | mw             | id  | ri              |
|----------|-----------|--------------|--------------|------------|---------|-----------|---------|----------------|-----|-----------------|
| input metabolite name | nist metabolite name | match score  | reverse match score | probability | library | cas #    | formula | molecular weight | id # | retention index |



**nistAutoSearch** tool requires listed open source [CRAN](https://cran.r-project.org) packages: [mssearchr](https://github.com/AndreySamokhin/mssearchr)

<<<<<<< HEAD
=======

>>>>>>> 0a83de2a51709d095f34cbf9f68af2671b424cf6
