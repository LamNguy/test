index=0
for d in mpathd mpathe mpathc; do
    parted /dev/mapper/${d} -s -- mklabel gpt mkpart KOLLA_SWIFT_DATA 1 -1
    sudo mkfs.xfs -f -L d${index} /dev/${d}1
    (( index++ ))
done
