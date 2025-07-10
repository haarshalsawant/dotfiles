{
  # I/O scheduler
  services.udev.extraRules = ''
    # NVMe SSD: none (noop)
    ACTION=="add|change", KERNEL=="nvme0n1", ATTR{queue/scheduler}="none"
    # HDD: bfq (good for HDD, or use 'mq-deadline' for lowest latency)
    ACTION=="add|change", KERNEL=="sda", ATTR{queue/scheduler}="mq-deadline"
  '';
}
