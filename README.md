# priceflyer
## Idea:
Provide expected over-time price-changes (increases) as info to help hesitant user that would ideally want to wait before really buying a given flight ticket
1. Create DB of flights incl. price-evolution. Scrape price data for many connections (for only a subset of e.g. airport-pairs), along with key characteristics and incl. evolution of price
2. Train AI: learn expectation value, maybe also e.g. decile distribution, of price move over time for given flight characteristics (incl. base price). Ideally price change expectation can robustly be predicted even for connections from e.g. airports which we have not scraped data from, but know few basic characteristics of)
3. Allow users to get prediction for given flight with given initial price

For now, flight DB is based on expedia.com only; presumption is it is among the standard competitive booking pages for buying flights at anyways very similar price

## Example URL
Make sure the date is updated to one in the reasonably close future, not in the past

https://www.expedia.com/Flights-Search?trip=oneway&leg1=from:ZRH,to:LON,departure:06/17/2019TANYT&passengers=adults:1,children:0,seniors:0,infantinlap:Y&options=cabinclass%3Aeconomy&mode=search&origref=www.expedia.com

## Requirements
1. Python 3, e.g. 3.5, with the packages in requirements.txt
2. flib_py: tiny library of tiny py convenience utilities

## Setup in Linux (tested with 16.04)
Run `./setup.sh`

This auto-installs py virtualenv incl. the required packages (cf. requirements.txt), and clones the small py module flib_py from https://bitbucket.org/fhabermacher/flib_py


Note, if problem with lxml package installation (lxml etree): may need to care to have the right lxml version installed, cf. https://lxml.de/installation.html for more info
