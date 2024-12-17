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
4. Exporting search results and processed data to CSV files.
5. Automatic installation all dependencies
6. Automatic MSP (NIST) file corruption fix

**nistAutoSearch** tool requires listed open source [CRAN](https://cran.r-project.org) packages: [mssearchr](https://github.com/AndreySamokhin/mssearchr)