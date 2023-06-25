alias gr := get-reqs
alias cr := check-reqs

# Get list of imported packages in python scripts with local installed packages
get-reqs SRC:
    pipreqs {{SRC}} --mode no-pin --savepath requirements-project.txt --use-local --force

# Check list of imported libraries from `get-reqs` with user defined requirements.txt
check-reqs SRC:
    pipreqs {{SRC}} --mode no-pin --savepath requirements-project.txt --use-local --force
    pipreqs --savepath requirements-project.txt --diff requirements.txt --use-local