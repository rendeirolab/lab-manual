# Lab infrastructure

This document describes the infrastructure used in the lab, including CeMM-provided or our own infrastructure.
So far it details only computational infrastructure.

## Lab infrastructure

#### Hardware

- Hilde workstation: [setting up and maintaining the hilde workstation: hilde_workstation.md](https://github.com/rendeirolab/labdocs/blob/main/hilde_workstation.md)
    - Usage can be booked through its dedicated calendar:
        - HTML: https://outlook.office365.com/owa/calendar/92e5463911e04b688330fbd26c75faab@cemm.oeaw.ac.at/7dce5f2f61f84753bca69c49a309581114314229400116418487/calendar.html
        - ICS: https://outlook.office365.com/owa/calendar/92e5463911e04b688330fbd26c75faab@cemm.oeaw.ac.at/7dce5f2f61f84753bca69c49a309581114314229400116418487/calendar.ics

#### VMs

- Cytomine: [setting up and maintaining the cytomine VM: cytomine.md](https://github.com/rendeirolab/labdocs/blob/main/cytomine.md)

#### Cloud resources

[Read the documentation on using Azure web services here: azure.md](https://github.com/rendeirolab/labdocs/blob/main/azure.md)

## CeMM infrastructure

Refer to the [CeMM Intranet documentation](https://cemmat.sharepoint.com/sites/Intranet) for updated information.
Below are a few notes on things which are not covered there:

#### Printing from Linux

CeMM has Canon iR-ADV C5735/5740 printers. They support IPP printing through CUPS.

Install CUPS:

```bash
sudo apt-get install cups
```

Add printers:

```bash
sudo lpadmin -p CeMM_level_2 -E -v ipp://193.171.185.37/ipp -m everywhere
sudo lpadmin -p CeMM_level_3 -E -v ipp://193.171.185.212/ipp -m everywhere
sudo lpadmin -p CeMM_level_4 -E -v ipp://193.171.185.39/ipp -m everywhere
sudo lpadmin -p CeMM_level_5 -E -v ipp://193.171.185.40/ipp -m everywhere
sudo lpadmin -p CeMM_level_6 -E -v ipp://193.171.185.38/ipp -m everywhere
sudo lpadmin -p CeMM_level_7 -E -v ipp://193.171.185.41/ipp -m everywhere
```
