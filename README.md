# 🛠️ Painel de Suporte Técnico & Diagnóstico (Windows)

[![Windows](https://img.shields.io/badge/OS-Windows-blue.svg)](https://www.microsoft.com/windows)
[![Shell](https://img.shields.io/badge/Shell-Batch%20%2F%20PowerShell-green.svg)]()
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> Uma ferramenta unificada em linha de comando (CLI) projetada para agilizar o trabalho de técnicos de TI e administradores de sistemas em tarefas de manutenção, auditoria, diagnóstico de rede, reparo do Windows e segurança.

---

## 📋 Sumário
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Como Usar & Auto-Elevação](#-como-usar--auto-elevação)
- [Versões do Script](#-versões-do-script)
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
* **Privilégios:** A versão completa requer privilégios de Administrador. *(Consulte a seção de Auto-Elevação abaixo)*.
* **Winget (Opcional):** Necessário para a função de atualização de aplicativos (já incluso nativamente no Windows 11 e versões recentes do Windows 10).

---

## 🚀 Como Usar & Auto-Elevação

Agora o script conta com **Auto-Elevação de Privilégios (UAC)** automática! Não é mais necessário clicar com o botão direito e escolher *"Executar como Administrador"*.

1. Dê um **duplo clique** no arquivo `SuporteTech.bat`.
2. O script detectará se possui permissão de Administrador. Se não possuir, ele chamará a tela do **UAC (Controle de Conta de Usuário)** do Windows automaticamente solicitando a autorização.
3. Clique em **"Sim"** e o painel iniciará com todos os privilégios necessários ativados.

---

## 📦 Versões do Script

O repositório conta com duas versões organizadas de acordo com o nível de acesso necessário:

| Arquivo | Elevação de Admin | Recomendado para |
| :--- | :---: | :--- |
| `SuporteTech.bat` | ⚡ Automática (UAC) | Manutenção completa, reparos de sistema, segurança e rede avançada. |
| `SuporteTech_User.bat` | ❌ Não requer | Diagnósticos rápidos, checagem de IP, consulta de processos e suporte rápido ao usuário final. |

---

## 📁 Estrutura do Painel (Versão Completa)

| Opção | Módulo | Descrição Principal |
| :---: | :--- | :--- |
| **`[1]`** | **Rede** | `ipconfig`, `flushdns`, `release/renew`, `ping`, `netsh winsock` |
| **`[2]`** | **Sistema & Desempenho** | `systeminfo`, leitura de CPU via PowerShell, limpeza do `%temp%` |
| **`[3]`** | **Reparo do Windows** | `sfc /scannow`, `DISM /RestoreHealth`, `gpupdate /force` |
| **`[4]`** | **Domínio & Usuários** | Gestão de `net user`, `net localgroup`, checagem de AD |
| **`[5]`** | **Atualizações** | `winget upgrade --all` e busca via `USOClient` |
| **`[6]`** | **Segurança** | Auditoria WMI de Antivírus, `Start-MpScan` e reset de Firewall |
| **`[7]`** | **Atalhos** | Abertura rápida de consoles `.msc` e painel de controle |

---

## 🤝 Contribuição

Contribuições são super vindas! Se você deseja adicionar novas rotinas de suporte ou melhorar a performance das existentes:

1. Faça um **Fork** do projeto
2. Crie uma Branch para sua Feature (`git checkout -b feature/NovaFuncionalidade`)
3. Faça o **Commit** de suas alterações (`git commit -m 'Add: Nova funcionalidade para o menu'`)
4. Faça o **Push** para a Branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um **Pull Request**

---

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE) - sinta-se à vontade para modificar e utilizar em seus atendimentos técnicos.
SuporteTech.bat
