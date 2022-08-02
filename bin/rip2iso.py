#!/usr/bin/env python3
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

from tqdm import trange


@dataclass
class IsoInfo:
    """This class holds the required parsed isoinfo output."""

    logical_block_size: int = 0
    volume_size: int = 0


def main():
    if len(sys.argv) != 3:
        print("Error: Not enough arguments.", file=sys.stderr)
        print(f"Usage: {sys.argv[0]} DEVICE ISO", file=sys.stderr)
        return -1
    device = Path(sys.argv[1]).resolve()
    iso = Path(sys.argv[2]).resolve()
    try:
        rip_to_iso(device, iso)
    except Exception as err:
        print(f"Error: {err}", file=sys.stderr)
        return -2
    return 0


def rip_to_iso(device: Path, iso: Path):
    """Rip the contents of device `device` to an ISO file.

    Args:
      device: The device to rip
      iso: Destination ISO file
    """
    sizes = get_iso_information(device)
    read_to_iso(device, iso, sizes)


def get_iso_information(device: Path) -> IsoInfo:
    """Use isoinfo to obtain required information about the disk to rip.

    This function calls isoinfo and get the logical block size and the volume size.
    """
    res = subprocess.run(
        ("isoinfo", "-d", "-i", device), check=True, capture_output=True
    )
    return parse_isoinfo_output(res.stdout)


def parse_isoinfo_output(isoinfo: str) -> IsoInfo:
    """Parse the output of isoinfo."""
    parsed = IsoInfo()
    for line in isoinfo.splitlines():
        if line.startswith(b"Logical block size is:"):
            parsed.logical_block_size = int(line.strip().split(b":")[-1])
        elif line.startswith(b"Volume size is:"):
            parsed.volume_size = int(line.strip().split(b":")[-1])
    return parsed


def read_to_iso(device: Path, iso: Path, isoinfo: IsoInfo):
    """Read from the given device and write to the ISO file."""
    with device.open("rb") as dev_in, iso.open("wb") as iso_out:
        for _ in trange(isoinfo.volume_size):
            chunk = dev_in.read(isoinfo.logical_block_size)
            iso_out.write(chunk)


if __name__ == "__main__":
    sys.exit(main())
