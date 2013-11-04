# Basic unit test for the playbook
# Make sure ansible is happy with the playbook
# Run this script from the root directory

function testcase {
    cmd=$1
    output=`$cmd 2>&1`
    if [ "$?" != "0" ]; then
        fail "FAILED: cmd='$cmd', output=\n$output"
    fi
    echo "PASSED: cmd='$cmd'"
}

function fail {
    echo -e $1
    exit 1
}

# Space separated list of playbooks to test
playbooks="generate.yml"

# Check Syntax of Playbooks (use localhost as the explicit inventory)
for p in $playbooks; do
    testcase "ansible-playbook $p -i 'localhost,' --syntax-check"
done

# Run the playbooks in --list-hosts only mode
for p in $playbooks; do
    testcase "ansible-playbook $p -i test/fake-hosts.ini --list-hosts"
done

echo "All Tests Passed"
