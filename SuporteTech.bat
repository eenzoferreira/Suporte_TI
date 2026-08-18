@echo off
chcp 65001 >nul

:: ----------------------------------------------------------------------
:: REINICIA O SCRIPT AUTOMATICAMENTE COMO ADMINISTRADOR
:: ----------------------------------------------------------------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando privilegios de Administrador...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:menu
cls
echo =====================================================================
echo                    PAINEL DE SUPORTE TÉCNICO
echo =====================================================================
echo  [1] Diagnóstico de Rede
echo  [2] Desempenho e Limpeza de Sistema
echo  [3] Reparo e Manutenção do Windows
echo  [4] Domínio e Usuários Locais
echo  [5] Central de Atualizações (Programas, Drivers e Windows)
echo  [6] Central de Segurança e Proteção (Antivírus, Firewall e Malware)
echo  [7] Atalhos para Ferramentas do Sistema
echo  [0] SAIR
echo =====================================================================
set /p opcao=Escolha uma opção [0-7]: 

if "%opcao%"=="1" goto menu_rede
if "%opcao%"=="2" goto menu_sistema
if "%opcao%"=="3" goto menu_reparo
if "%opcao%"=="4" goto menu_usuarios
if "%opcao%"=="5" goto menu_atualizacoes
if "%opcao%"=="6" goto menu_seguranca
if "%opcao%"=="7" goto menu_atalhos
if "%opcao%"=="0" goto fim

echo.
echo Opção inválida! Tente novamente.
pause
goto menu

:: =======================================================================
:: SEÇÃO 1: REDE
:: =======================================================================
:menu_rede
cls
echo ========================= FERRAMENTAS DE REDE =========================
echo  [1] Informações Completas da Rede (ipconfig /all)
echo  [2] Limpar Cache DNS (Flush DNS)
echo  [3] Renovar Endereço IP (Release / Renew)
echo  [4] Testar Conectividade com Servidor ou IP (Ping)
echo  [5] Resetar Configurações de Rede (Winsock / IP Stack)
echo  [6] Exibir Tabela de Rotas
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p opcao=Escolha uma opção: 

if "%opcao%"=="1" goto ipall
if "%opcao%"=="2" goto flushdns
if "%opcao%"=="3" goto renewip
if "%opcao%"=="4" goto pingserv
if "%opcao%"=="5" goto winsock
if "%opcao%"=="6" goto rotas
if "%opcao%"=="0" goto menu

echo Opção inválida!
pause
goto menu_rede

:ipall
cls
ipconfig /all
pause
goto menu_rede

:flushdns
cls
ipconfig /flushdns
pause
goto menu_rede

:renewip
cls
echo Liberando IP atual...
ipconfig /release
echo Solicitando novo IP...
ipconfig /renew
echo Concluído!
pause
goto menu_rede

:pingserv
cls
set /p ipNome=Digite o nome do host ou IP do Servidor: 
ping %ipNome%
pause
goto menu_rede

:winsock
cls
echo Redefinindo catálogos e pilha TCP/IP...
netsh winsock reset
netsh int ip reset
echo.
echo [ATENÇÃO] É necessário reiniciar o computador para aplicar o reset completo.
pause
goto menu_rede

:rotas
cls
route print
pause
goto menu_rede

:: =======================================================================
:: SEÇÃO 2: SISTEMA E DESEMPENHO
:: =======================================================================
:menu_sistema
cls
echo ===================== SISTEMA E DESEMPENHO =======================
echo  [1] Informações Completas do Sistema (systeminfo)
echo  [2] Processos com maior uso de CPU (Top 10)
echo  [3] Limpar Arquivos Temporários
echo  [4] Habilitar Logon de Convidado Inseguro (Compartilhamentos SMB)
echo  [5] Reiniciar Computador
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p opcao=Escolha uma opção: 

if "%opcao%"=="1" goto systeminfo
if "%opcao%"=="2" goto cpu
if "%opcao%"=="3" goto lentidao
if "%opcao%"=="4" goto compartilhamento
if "%opcao%"=="5" goto reiniciar
if "%opcao%"=="0" goto menu

echo Opção inválida!
pause
goto menu_sistema

:systeminfo
cls
systeminfo
pause
goto menu_sistema

:cpu
cls
echo Coletando os 10 processos que mais consomem CPU...
echo.
powershell -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 -Property Id, ProcessName, @{Name='CPU(s)';Expression={round($_.CPU,2)}} | Format-Table -AutoSize"
pause
goto menu_sistema

:lentidao
cls
echo Limpando pastas temporárias e cache...
del /f /s /q "%temp%\*.*" >nul 2>&1
del /f /s /q "%SystemRoot%\Temp\*.*" >nul 2>&1
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo.
echo Limpeza de arquivos temporários concluída!
pause
goto menu_sistema

:compartilhamento
cls
powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false -Confirm:$false"
powershell -Command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Confirm:$false"
echo.
echo Acesso a compartilhamentos de rede inseguros/antigos ativado.
pause
goto menu_sistema

:reiniciar
cls
set /p confirm=Tem certeza que deseja reiniciar agora? (S/N): 
if /i "%confirm%"=="S" shutdown /r /t 5 /c "Reinicialização solicitada pelo Suporte Técnico."
goto menu_sistema

:: =======================================================================
:: SEÇÃO 3: REPARO DO WINDOWS
:: =======================================================================
:menu_reparo
cls
echo ===================== REPARO E MANUTENÇÃO =========================
echo  [1] Verificação de Arquivos do Sistema (SFC /scannow)
echo  [2] Reparo de Imagem do Windows (DISM RestoreHealth)
echo  [3] Atualizar Políticas de Grupo (GPUpdate /force)
echo  [4] Agendar Verificação do Disco (CHKDSK)
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p opcao=Escolha uma opção: 

if "%opcao%"=="1" goto sfc
if "%opcao%"=="2" goto dism
if "%opcao%"=="3" goto updategp
if "%opcao%"=="4" goto chkdsk
if "%opcao%"=="0" goto menu

echo Opção inválida!
pause
goto menu_reparo

:sfc
cls
echo Executando System File Checker...
sfc /scannow
pause
goto menu_reparo

:dism
cls
echo Executando reparo de imagem via DISM...
dism /online /cleanup-image /restorehealth
pause
goto menu_reparo

:updategp
cls
gpupdate /force
pause
goto menu_reparo

:chkdsk
cls
chkdsk C: /f /r
pause
goto menu_reparo

:: =======================================================================
:: SEÇÃO 4: DOMÍNIO E USUÁRIOS
:: =======================================================================
:menu_usuarios
cls
echo ===================== DOMÍNIO E USUÁRIOS ==========================
echo  [1] Listar Usuários Locais deste Computador
echo  [2] Listar Membros do Grupo Administradores Locais
echo  [3] Ver Status de Domínio / Workgroup
echo  [4] Ativar Conta de Administrador Local Integrada
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p opcao=Escolha uma opção: 

if "%opcao%"=="1" goto list_users
if "%opcao%"=="2" goto list_admins
if "%opcao%"=="3" goto domain_status
if "%opcao%"=="4" goto enable_admin
if "%opcao%"=="0" goto menu

echo Opção inválida!
pause
goto menu_usuarios

:list_users
cls
net user
pause
goto menu_usuarios

:list_admins
cls
net localgroup Administradores
pause
goto menu_usuarios

:domain_status
cls
powershell -Command "Get-CimInstance Win32_ComputerSystem | Select-Object Name, Domain, PartOfDomain, Workgroup | Format-List"
pause
goto menu_usuarios

:enable_admin
cls
net user Administrador /active:yes
echo Conta "Administrador" local ativada com sucesso.
pause
goto menu_usuarios

:: =======================================================================
:: SEÇÃO 5: CENTRAL DE ATUALIZAÇÕES
:: =======================================================================
:menu_atualizacoes
cls
echo ===================== CENTRAL DE ATUALIZAÇÕES =====================
echo  Buscando atualizações de programas e drivers pendentes...
echo ---------------------------------------------------------------------
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo [AVISO] O Gerenciador de Pacotes Winget não está instalado nesta máquina.
    echo Recomendado atualizar o Windows ou instalar o "App Installer" da Microsoft Store.
    echo.
) else (
    winget upgrade --include-unknown
)
echo ---------------------------------------------------------------------
echo.
echo O que você deseja fazer com as atualizações?
echo.
echo  [1] Atualizar TUDO agora (Programas, Drivers e Windows Update)
echo  [2] Escolher apenas um programa ou driver específico para atualizar
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set "op_upd="
set /p op_upd=Escolha uma opção [0-2]: 

if "%op_upd%"=="1" goto update_all
if "%op_upd%"=="2" goto update_select
if "%op_upd%"=="0" goto menu

echo Opção inválida!
pause
goto menu_atualizacoes

:update_all
cls
echo =====================================================================
echo  EXECUTANDO ATUALIZAÇÃO COMPLETA
echo =====================================================================
echo.
echo [1/2] Atualizando Programas e Drivers via Winget...
winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements

echo.
echo [2/2] Iniciando verificação do Windows Update...
powershell -Command "Start-Process USOClient.exe -ArgumentList 'StartInteractiveScan'"
echo Verificação do Windows Update solicitada em segundo plano.
echo.
echo Atualizações concluídas!
pause
goto menu_atualizacoes

:update_select
cls
echo =====================================================================
echo  ATUALIZAÇÃO DE ITEM ESPECÍFICO
echo =====================================================================
echo.
set "pkg_id="
set /p pkg_id=Digite o ID do Programa/Driver (conforme listado na tabela): 

if "%pkg_id%"=="" (
    echo Nenhum ID foi informado.
    pause
    goto menu_atualizacoes
)

echo.
echo Atualizando o item %pkg_id%...
winget upgrade --id "%pkg_id%" --accept-package-agreements --accept-source-agreements
echo.
pause
goto menu_atualizacoes

:: =======================================================================
:: SEÇÃO 6: CENTRAL DE SEGURANÇA E PROTEÇÃO
:: =======================================================================
:menu_seguranca
cls
echo ================= CENTRAL DE SEGURANÇA E PROTEÇÃO =================
echo  [1] Diagnóstico de Segurança e Lista de Ações Recomendadas
echo  [2] Varredura Rápida de Malware / Vírus (Windows Defender)
echo  [3] Varredura Completa de Malware / Vírus (Windows Defender)
echo  [4] Verificar Status do Firewall do Windows
echo  [5] Ativar e Restaurar Firewall para as Configurações Padrão
echo  [6] Verificação Profunda de Arquivos Corrompidos (SFC + DISM)
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p op_seg=Escolha uma opção [0-6]: 

if "%op_seg%"=="1" goto seg_diag
if "%op_seg%"=="2" goto seg_quickscan
if "%op_seg%"=="3" goto seg_fullscan
if "%op_seg%"=="4" goto seg_fw_status
if "%op_seg%"=="5" goto seg_fw_reset
if "%op_seg%"=="6" goto seg_corrupted
if "%op_seg%"=="0" goto menu

echo Opção inválida!
pause
goto menu_seguranca

:seg_diag
cls
echo =====================================================================
echo  DIAGNÓSTICO DE SEGURANÇA E LISTA DE RECOMENDAÇÕES
echo =====================================================================
echo.
powershell -Command "& { Write-Host '1. STATUS DO ANTIVÍRUS:' -ForegroundColor Yellow; $av = Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct -ErrorAction SilentlyContinue; if ($av) { foreach ($a in $av) { Write-Host '   [+] Detectado:' $a.displayName } } else { Write-Host '   [!] ALERTA: Nenhum Antivírus cadastrado detectado!' -ForegroundColor Red }; Write-Host '`n2. STATUS DO FIREWALL DO WINDOWS:' -ForegroundColor Yellow; $fw = Get-NetFirewallProfile; foreach ($p in $fw) { $status = if ($p.Enabled) { '[OK] Ativado' } else { '[ALERTA] DESATIVADO' }; $color = if ($p.Enabled) { 'Green' } else { 'Red' }; Write-Host ('   -> Perfil ' + $p.Name + ': ') -NoNewline; Write-Host $status -ForegroundColor $color }; Write-Host '`n3. CONTROLE DE CONTA DE USUÁRIO (UAC):' -ForegroundColor Yellow; $uac = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -ErrorAction SilentlyContinue).EnableLUA; if ($uac -eq 1) { Write-Host '   [OK] UAC está Ativado (Proteção contra alterações não autorizadas).' -ForegroundColor Green } else { Write-Host '   [ALERTA] UAC está Desativado!' -ForegroundColor Red }; Write-Host '`n=================================================================' -ForegroundColor DarkGray; Write-Host ' CHECKLIST DE AÇÕES PARA O TÉCNICO DE MANUTENÇÃO:' -ForegroundColor Cyan; Write-Host '=================================================================' -ForegroundColor DarkGray; Write-Host ' [ ] Se algum Perfil de Firewall estiver DESATIVADO: Use a Opção 5 do menu.'; Write-Host ' [ ] Se houver relatos de pop-ups ou lentidão: Execute a Varredura (Opção 2 ou 3).'; Write-Host ' [ ] Se o sistema apresentar erros de DLL ou tela azul: Execute a Opção 6.'; Write-Host ' [ ] Caso encontre ameaças persistentes: Inicie em Modo de Segurança para remoção.' }"
echo.
pause
goto menu_seguranca

:seg_quickscan
cls
echo =====================================================================
echo  VARREDURA RÁPIDA DE MALWARE (WINDOWS DEFENDER)
echo =====================================================================
echo.
echo [1/2] Atualizando definições de vírus e spyware...
powershell -Command "Update-MpSignature"
echo.
echo [2/2] Executando Varredura Rápida...
powershell -Command "Start-MpScan -ScanType QuickScan"
echo.
echo Varredura Rápida Concluída!
pause
goto menu_seguranca

:seg_fullscan
cls
echo =====================================================================
echo  VARREDURA COMPLETA DE MALWARE (WINDOWS DEFENDER)
echo =====================================================================
echo.
echo [ATENÇÃO] A varredura completa pode levar bastante tempo dependendo do tamanho do disco.
echo.
echo [1/2] Atualizando definições de vírus e spyware...
powershell -Command "Update-MpSignature"
echo.
echo [2/2] Executando Varredura Completa...
powershell -Command "Start-MpScan -ScanType FullScan"
echo.
echo Varredura Completa Concluída!
pause
goto menu_seguranca

:seg_fw_status
cls
echo =====================================================================
echo  STATUS DOS PERFIS DO FIREWALL DO WINDOWS
echo =====================================================================
echo.
netsh advfirewall show allprofiles state
echo.
pause
goto menu_seguranca

:seg_fw_reset
cls
echo =====================================================================
echo  RESTAURANDO CONFIGURAÇÕES PADRÃO DO FIREWALL
echo =====================================================================
echo.
echo Ativando todos os perfis e redefinindo regras padrão...
netsh advfirewall set allprofiles state on
netsh advfirewall reset
echo.
echo Firewall ativado e redefinido com sucesso!
pause
goto menu_seguranca

:seg_corrupted
cls
echo =====================================================================
echo  VERIFICAÇÃO DE ARQUIVOS CORROMPIDOS (SFC + DISM)
echo =====================================================================
echo.
echo [1/2] Analisando integridade da imagem do Windows (DISM)...
dism /online /cleanup-image /restorehealth
echo.
echo [2/2] Analisando e reparando arquivos de sistema corrompidos (SFC)...
sfc /scannow
echo.
echo Verificação e Reparo Concluídos!
pause
goto menu_seguranca

:: =======================================================================
:: SEÇÃO 7: ATALHOS DE FERRAMENTAS DO WINDOWS
:: =======================================================================
:menu_atalhos
cls
echo ==================== ATALHOS DO SISTEMA ===========================
echo  [1] Gerenciador de Dispositivos (devmgmt.msc)
echo  [2] Gerenciador de Tarefas (taskmgr)
echo  [3] Serviços do Windows (services.msc)
echo  [4] Editor do Registro (regedit)
echo  [5] Painel de Controle Clássico
echo  [0] Voltar ao Menu Principal
echo =====================================================================
set /p opcao=Escolha uma opção: 

if "%opcao%"=="1" start devmgmt.msc & goto menu_atalhos
if "%opcao%"=="2" start taskmgr & goto menu_atalhos
if "%opcao%"=="3" start services.msc & goto menu_atalhos
if "%opcao%"=="4" start regedit & goto menu_atalhos
if "%opcao%"=="5" start control & goto menu_atalhos
if "%opcao%"=="0" goto menu

echo Opção inválida!
pause
goto menu_atalhos

:fim
cls
echo Encerrando o painel de suporte...
timeout /t 2 >nul
exit
