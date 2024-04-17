Download promtail-windows-amd64.exe.zip
https://github.com/grafana/loki/releases/

Download nssm
https://www.nssm.cc/download

установить promtail как службу
.nssm.exe install promtail
указать пути до promtail
указать пути до логов STDOUT STDERR
arguments:
--config.file=promtail-config.yaml
