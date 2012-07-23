#!/bin/bash

# Shut down the virtual machine and go back one snapshot
alias vrollback='vagrant halt && vagrant snap back'

# Same as above plus a 'vagrant provision'
alias vrepro='vagrant halt && vagrant snap back && vagrant provision'

# (h)ealth_ispector (i)nspector
alias hi='health_inspector inspect'

# (l)ibrarian-(c)hef
alias lc="librarian-chef"
