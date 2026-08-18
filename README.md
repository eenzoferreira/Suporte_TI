# 🛠️ Painel de Suporte Técnico & Diagnóstico (Windows)

[![Windows](https://img.shields.io/badge/OS-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Shell](https://img.shields.io/badge/Shell-Batch%20%2F%20PowerShell-green.svg)]()
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> Uma ferramenta unificada em linha de comando (CLI) projetada para agilizar o trabalho de técnicos de TI e administradores de sistemas em tarefas de manutenção, auditoria, diagnóstico de rede, reparo do Windows e segurança.

---

## 📋 Sumário
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Como Usar](#-como-usar)
- [Estrutura do Painel](#-estrutura-do-painel)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

---

## ✨ Funcionalidades

O script combina a simplicidade do **Batch** com a potência do **PowerShell**, oferecendo 7 módulos principais:

* 🌐 **Diagnóstico de Rede:** Leitura completa de IP, renovação de concessão DHCP, flush DNS, reset de pilha TCP/IP (Winsock) e rotas.
* ⚡ **Desempenho & Limpeza:** Varredura do top 10 processos por uso de CPU, limpeza profunda de temporários e liberação de acessos a compartilhamentos SMB antigos.
* 🔧 **Reparo do Windows:** Verificação rápida e profunda de integridade com `SFC /scannow`, `DISM RestoreHealth`, `GPUpdate` e agendamento de `CHKDSK`.
* 👤 **Domínio e Usuários:** Auditoria de contas locais, grupo de Administradores, ativação de conta admin nativa e checagem de status de Active Directory / Workgroup.
* 🔄 **Central de Atualizações:** Integração nativa com o `Winget` para atualizar programas, drivers e buscar atualizações no Windows Update.
* 🛡️ **Segurança & Proteção:** Auditoria de Antivírus/Firewall/UAC, varredura rápida/completa com Windows Defender, restauração de Firewall e reparo de arquivos infectados.
* 🚀 **Atalhos Rápidos:** Acesso com um clique aos consoles de gerenciamento (`devmgmt.msc`, `services.msc`, `regedit`, `taskmgr`, `control`).

---

## ⚠️ Pré-requisitos

* **Sistema Operacional:** Windows 10, Windows 11 ou Windows Server.
* **Privilégios:** **Obrigatório executar como Administrador** para que os comandos de reparo (`sfc`, `dism`, `netsh`) e segurança funcionem corretamente.
* **Winget (Opcional):** Necessário para a função de atualização de aplicativos (já incluso nativamente no Windows 11 e versões recentes do Windows 10).

---

## 🚀 Como Usar

### Opção 1: Download Direto
1. Baixe o arquivo `SuporteTech.bat` deste repositório.
2. Clique com o **botão direito** no arquivo e selecione **"Executar como Administrador"**.

### Opção 2: Clonando o Repositório
```bash
# Clone este repositório
git clone [https://github.com/SEU-USUARIO/NOME-DO-REPOSITORIO.git](https://github.com/SEU-USUARIO/NOME-DO-REPOSITORIO.git)

# Acesse a pasta do projeto
cd NOME-DO-REPOSITORIO

# Execute o script no CMD do Windows (como Admin)
SuporteTech.bat
