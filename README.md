# Investigating_Low_Res_NMT
The project aims at investigating low resource scenario with Neural Machine Translation and Statistical Machine Translation.

### Languages:
To study the low resource scenario, English-Tamil and Hindi-Tamil language pairs have been considered.

### Dataset 
The data was retrieved from open source websites - OPUS and GroundAI. The English-Tamil corpus consists of 2,22,367 sentence
pairs. Hindi-Tamil language pair consists of 1,00,047 sentence pairs.

### Tools Used: 
OpenNMT Toolkit - For Neural Machine Translation system <br/>
Moses - For Statistical Machine Translation system <br/>
Latex Editor - For documentation of Report Work.

All the source code for data preprocessing are present in cleaning_scripts/ directory. <br/>
All the source code for SMT system are present in smt_scripts/ directory. <br/>
The Neural Machine Translation system code for English-Tamil and Hindi-Tamil language pair can be found in nmt_enta_job/ and 
nmt_hita_job/ respectively. <br/>

All the code were executed on GPU enabled systems in Grove Cluster, the DCU Cluster for ADAPT Research Centre. 

