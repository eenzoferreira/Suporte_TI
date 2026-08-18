@echo off
chcp 65001 >nul
title PAINEL DE SUPORTE TÉCNICO (MODO USUÁRIO)

:menu
cls
echo =====================================================================
echo               PAINEL DE SUPORTE TÉCNICO (MODO USUÁRIO)
echo =====================================================================
echo  [1] Diagnóstico de Rede Básica (IP, Ping, Rotas)
echo  [2] Diagnóstico do Sistema e Processos
echo  [3] Limpeza de Temporários do Usuário (%temp%)
echo  [4] Status de Domínio e Usuário Logado
echo  [5] Atalhos para Ferramentas de Usuário
echo  [0] SAIR
echo =====================================================================
set "opcao="
set /p opcao=Escolha uma opção [0-5]: 

if "%opcao%"=="1" goto menu_rede
if "%opcao%"=="2" goto menu_sistema
if "%opcao%"=="3" goto lentidao
if "%opcao%"=="4" goto domain_status
if "%opcao%"=="5" goto menu_atalhos
if "%opcao%"=="0" goto fim

echo.
echo Opção inválida! Tente novamente.
pause
goto menu

:menu_rede
cls
echo ========================= DIAGNÓSTICO DE REDE =========================
echo  [1] Ver Endereço IP (ipconfig)
echo  [2] Testar Conectividade (Ping)
echo  [3] Exibir Tabela de Rotas (route print)
echo  [0] Voltar
echo =====================================================================
set "op_r="
set /p op_r=Escolha uma opção: 

if "%op_r%"=="1" cls & ipconfig & pause & goto menu_rede
if "%op_r%"=="2" goto pingserv
if "%op_r%"=="3" cls & route print & pause & goto menu_rede
if "%op_r%"=="0" goto menu
goto menu_rede

:pingserv
cls
set /p ipNome=Digite o nome do host ou IP: 
ping %ipNome%
pause
goto menu_rede

:menu_sistema
cls
echo ===================== SISTEMA E PROCESSOS =======================
echo  [1] Informações do Sistema (systeminfo)
echo  [2] Processos com maior uso de CPU (Top 10)
echo  [0] Voltar
echo =====================================================================
set "op_s="
set /p op_s=Escolha uma opção: 

if "%op_s%"=="1" cls & systeminfo & pause & goto menu_sistema
if "%op_s%"=="2" goto cpu
if "%op_s%"=="0" goto menu
goto menu_sistema

:cpu
cls
echo Coletando processos com maior uso de CPU...
echo.
powershell -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 -Property Id, ProcessName, @{Name='CPU(s)';Expression={round($_.CPU,2)}} | Format-Table -AutoSize"
pause
goto menu_sistema

:lentidao
cls
echo Limpando pasta temporária do usuário corrente...
del /f /s /q "%temp%\*.*" >nul 2>&1
echo.
echo Limpeza da pasta %temp% concluída!
pause
goto menu

:domain_status
cls
powershell -Command "Get-CimInstance Win32_ComputerSystem | Select-Object Name, Domain, PartOfDomain, Workgroup | Format-List"
pause
goto menu

:menu_atalhos
cls
echo ==================== ATALHOS DO USUÁRIO ===========================
echo  [1] Gerenciador de Tarefas (taskmgr)
echo  [2] Painel de Controle Clássico
echo  [3] Informações do Sistema (msinfo32)
echo  [0] Voltar
echo =====================================================================
set "op_a="
set /p op_a=Escolha uma opção: 

if "%op_a%"=="1" start taskmgr & goto menu_atalhos
if "%op_a%"=="2" start control & goto menu_atalhos
if "%op_a%"=="3" start msinfo32 & goto menu_atalhos
if "%op_a%"=="0" goto menu
goto menu_atalhos

:fim
cls
echo Encerrando...
timeout /t 2 >nul
exit
