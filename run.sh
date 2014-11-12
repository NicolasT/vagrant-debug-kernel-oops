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

echo "Crashing VM kernel..."
vagrant ssh -c "sudo bash -c 'echo c > /proc/sysrq-trigger'" &

echo "Give it some time..."
sleep 5

echo "Halting VM..."
vagrant halt -f

echo "Kernel log:"
echo
cat ${FN}
echo
