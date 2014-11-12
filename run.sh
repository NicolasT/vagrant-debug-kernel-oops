#!/bin/bash -ue

function fail() {
    echo "Error: $1"
    exit 1
}

vagrant --version > /dev/null 2>&1 || fail "vagrant not found"
socat -V > /dev/null 2>&1 || fail "socat not found"

FN=dmesg-$$

echo "Kernel logs will be in ${FN}"

echo "Launching VM..."
vagrant up

echo "Launching socat..."
socat -u ./tty GOPEN:$FN &

echo -n "Waiting for machine to be up and running... "
vagrant ssh -c true > /dev/null 2>&1
echo "OK!"

echo "Removing test status file"
test -e test_status && rm test_status

echo "Running test script..."
vagrant ssh -c "/vagrant/run-tests.sh" &

echo "Give it some time..."
sleep 5

echo "Test should have completed by now"
if ! test -e test_status;
then
    echo "No test status file though, failure"
    RC=1
else
    RC=$(cat test_status)
    echo "Test result is ${RC}"
fi

echo "Halting VM..."
vagrant halt -f

echo "Kernel log:"
echo
cat ${FN}
echo

exit ${RC}
