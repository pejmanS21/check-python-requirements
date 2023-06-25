alias gr := get-reqs
alias cer := check-extra-reqs
alias cerd := check-extra-reqs-default

# Get list of imported packages in python scripts
get-reqs SRC:
    pipreqs {{SRC}} --mode no-pin --savepath requirements-project.txt --force

# Get extra requirements from extracted requirements
check-extra-reqs SRC:
    just get-reqs {{SRC}}
    pip-extra-reqs --requirements-file requirements-project.txt {{SRC}} -v

# Get extra requirements from user requirements.txt
check-extra-reqs-default SRC:
    pip-extra-reqs --requirements-file requirements.txt {{SRC}} -v