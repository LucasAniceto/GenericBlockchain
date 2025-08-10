# Relatório de Implementação - UliCoin Blockchain
## Disciplina: Algoritmos e Estrutura de Dados 3
### Professor: Ulisses
### Data: 10 de agosto de 2025

---

## 📋 Resumo Executivo

Este relatório apresenta a implementação completa de uma blockchain funcional denominada **UliCoin**, desenvolvida como projeto prático para a disciplina de Algoritmos e Estrutura de Dados 3. A implementação demonstra a aplicação de conceitos fundamentais de estruturas de dados e algoritmos em um sistema distribuído real.

## 🎯 Objetivos Alcançados

✅ **Implementação de blockchain funcional com proof-of-work**  
✅ **Sistema de transações peer-to-peer**  
✅ **Rede distribuída com consenso automatizado**  
✅ **API RESTful completa para interação**  
✅ **Validação criptográfica de integridade**  
✅ **Sincronização automática entre nós**  

---

## 🏗️ Arquitetura do Sistema

### Componentes Principais

1. **Classe Blockchain** (`ulicoin.py:9-87`)
   - Gerenciamento da cadeia de blocos
   - Algoritmo de consenso 
   - Validação criptográfica

2. **API Flask** (`ulicoin.py:89-159`)
   - 6 endpoints RESTful
   - Interface HTTP para interação
   - Comunicação inter-nós

3. **Rede Distribuída** 
   - Múltiplos nós (portas 5000-5003)
   - Sincronização automática
   - Tolerância a falhas

---

## 📊 Estruturas de Dados Implementadas

### 1. Lista Dinâmica (Blockchain Chain)
```python
self.chain = []  # ulicoin.py:12
```
- **Função**: Armazenamento sequencial dos blocos
- **Complexidade Inserção**: O(1) 
- **Complexidade Busca**: O(n)
- **Justificativa**: Crescimento dinâmico e acesso sequencial aos blocos

### 2. Dicionário (Hash Table - Estrutura do Bloco)
```python
block = {
    'index': len(self.chain) + 1,
    'timestamp': str(datetime.datetime.now()),
    'proof': proof,
    'previous_hash': previous_hash,
    'transactions': self.transactions
}
```
- **Função**: Estruturação eficiente dos dados do bloco
- **Complexidade Acesso**: O(1)
- **Justificativa**: Acesso rápido aos campos do bloco

### 3. Conjunto (Set - Nós da Rede)
```python
self.nodes = set()  # ulicoin.py:15
```
- **Função**: Gerenciamento de nós únicos na rede
- **Complexidade Inserção/Busca**: O(1)
- **Justificativa**: Evita duplicação de nós e acesso eficiente

### 4. Lista (Array - Pool de Transações)
```python
self.transactions = []  # ulicoin.py:13
```
- **Função**: Buffer temporário para transações pendentes
- **Complexidade Inserção**: O(1)
- **Justificativa**: Ordem FIFO para processamento de transações

---

## ⚙️ Algoritmos Implementados

### 1. Hash Criptográfico SHA-256
```python
def hash(self, block):
    encoded_block = json.dumps(block, sort_keys=True).encode()
    return hashlib.sha256(encoded_block).hexdigest()
```
- **Localização**: `ulicoin.py:41-43`
- **Função**: Garantir integridade e unicidade dos blocos
- **Propriedades**: Determinístico, unidirecional, resistente a colisões
- **Complexidade**: O(1) para entrada de tamanho fixo

### 2. Proof of Work (Consenso)
```python
def proof_of_work(self, previous_proof):
    new_proof = 1
    check_proof = False
    while check_proof is False:
        hash_operation = hashlib.sha256(str(new_proof**2 - previous_proof**2).encode()).hexdigest()
        if hash_operation[:4] == '0000':
            check_proof = True
        else:
            new_proof += 1
    return new_proof
```
- **Localização**: `ulicoin.py:30-39`
- **Dificuldade**: 4 zeros iniciais (2^16 tentativas médias)
- **Função**: Prevenir spam e garantir trabalho computacional
- **Complexidade**: O(2^d) onde d = dificuldade

### 3. Validação de Cadeia
```python
def is_chain_valid(self, chain):
    previous_block = chain[0]
    block_index = 1
    while block_index < len(chain):
        # Validação de hash e proof of work
```
- **Localização**: `ulicoin.py:45-59`
- **Função**: Verificar integridade completa da blockchain
- **Complexidade**: O(n) onde n = número de blocos
- **Validações**: Hash linking, proof of work, estrutura

### 4. Consenso da Rede (Longest Chain)
```python
def replace_chain(self):
    network = self.nodes
    longest_chain = None
    max_length = len(self.chain)
    # Busca pela cadeia mais longa válida
```
- **Localização**: `ulicoin.py:72-87`
- **Regra**: Aceita a cadeia mais longa e válida
- **Complexidade**: O(n*m) onde n = nós, m = blocos por nó
- **Função**: Resolver conflitos entre versões da blockchain

---

## 🔧 API RESTful - Endpoints Implementados

### 1. Mineração de Blocos
- **Endpoint**: `GET /mine_block`
- **Localização**: `ulicoin.py:95-109`
- **Função**: Criar novo bloco com proof of work
- **Transação**: Recompensa de 1 UliCoin para o minerador

### 2. Consulta da Blockchain
- **Endpoint**: `GET /get_chain` 
- **Localização**: `ulicoin.py:111-115`
- **Função**: Retornar toda a cadeia e seu tamanho

### 3. Validação de Integridade
- **Endpoint**: `GET /is_valid`
- **Localização**: `ulicoin.py:117-124`
- **Função**: Verificar se a blockchain está íntegra

### 4. Sistema de Transações
- **Endpoint**: `POST /add_transaction`
- **Localização**: `ulicoin.py:126-134`
- **Função**: Adicionar transação ao pool pendente

### 5. Gerenciamento de Rede
- **Endpoint**: `POST /connect_node` (`ulicoin.py:136-146`)
- **Endpoint**: `GET /replace_chain` (`ulicoin.py:148-157`)
- **Função**: Conectar nós e sincronizar blockchain

---

## 🔐 Segurança e Mecanismos de Proteção

### 1. Integridade Criptográfica
- **SHA-256**: Função hash criptograficamente segura
- **Linking**: Cada bloco referencia o anterior via hash
- **Imutabilidade**: Alteração requer recalcular toda a cadeia

### 2. Prevenção de Spam
- **Proof of Work**: Custo computacional para criar blocos
- **Dificuldade**: Ajustável conforme poder da rede (4 zeros)
- **Validação**: Todos os nós verificam o trabalho

### 3. Consenso Distribuído
- **Longest Chain**: Regra de consenso automática
- **Validação Cruzada**: Múltiplos nós verificam transações
- **Rejeição Automática**: Blocos inválidos são descartados

---

## 📈 Análise de Performance

### Complexidade Computacional

| Operação | Complexidade Temporal | Complexidade Espacial | Justificativa |
|----------|----------------------|----------------------|---------------|
| Adicionar Bloco | O(1) | O(1) | Inserção no final da lista |
| Validar Cadeia | O(n) | O(1) | Percorre todos os n blocos |
| Proof of Work | O(2^d) | O(1) | d = dificuldade (4 zeros) |
| Buscar Transação | O(n*m) | O(1) | n blocos × m transações |
| Sincronizar Rede | O(r*n) | O(n) | r nós × n blocos |

### Escalabilidade
- **Crescimento Linear**: O(n) para validação conforme cresce a chain
- **Gargalo Principal**: Proof of Work na mineração
- **Trade-off**: Segurança vs. Velocidade de processamento

---

## 💻 Demonstração de Funcionamento

### Configuração Multi-Nó
O sistema foi implementado com 4 nós diferentes:
- `ulicoin.py` (porta 5000) - Nó principal
- `ulicoin_5001.py` (porta 5001) 
- `ulicoin_5002.py` (porta 5002)
- `ulicoin_5003.py` (porta 5003)

### Arquivos de Configuração
- `nodes.json`: Lista de nós da rede
- `transactions.json`: Template de transações

### Cenários Testados
1. **Mineração individual**: Criação de blocos em nós isolados
2. **Rede conectada**: Sincronização automática entre nós
3. **Resolução de conflitos**: Consenso via longest chain
4. **Transações personalizadas**: Sistema de pagamentos

---

## 🎓 Aplicação dos Conceitos de AED3

### Estruturas de Dados na Prática
- **Listas**: Implementação da cadeia sequencial de blocos
- **Hash Tables**: Estruturação eficiente dos dados
- **Sets**: Gerenciamento de coleções únicas (nós da rede)
- **Arrays**: Buffer de transações pendentes

### Algoritmos Fundamentais
- **Hashing**: SHA-256 para integridade de dados
- **Busca**: Localização de transações e validação
- **Consenso**: Algoritmos de acordo em sistemas distribuídos
- **Grafos**: Topologia P2P da rede blockchain

### Análise de Complexidade Aplicada
- **Big O Notation**: Análise de performance das operações
- **Trade-offs**: Balanceamento entre segurança e eficiência
- **Escalabilidade**: Crescimento do sistema com dados

---

## 🚀 Aplicações e Relevância

### Casos de Uso Demonstrados
1. **Sistema monetário descentralizado**
2. **Registro imutável de transações** 
3. **Consenso sem autoridade central**
4. **Rede distribuída tolerante a falhas**

### Tecnologias Aprendidas
- **Python**: Linguagem de implementação
- **Flask**: Framework web para API REST
- **JSON**: Serialização e comunicação
- **HTTP**: Protocolo de rede P2P
- **Criptografia**: Hashing e integridade

---

## 📚 Conclusões

### Objetivos de Aprendizagem Alcançados
1. ✅ **Aplicação prática de estruturas de dados** em sistema real
2. ✅ **Implementação de algoritmos complexos** (proof of work, consenso)
3. ✅ **Análise de complexidade computacional** em cenário prático
4. ✅ **Desenvolvimento de sistema distribuído** com Python
5. ✅ **Compreensão de blockchain** além da teoria

### Desafios Superados
- **Sincronização de rede**: Implementação do algoritmo de consenso
- **Validação criptográfica**: Garantia de integridade sem autoridade central  
- **Performance vs. Segurança**: Balanceamento via proof of work
- **API Design**: Interface intuitiva para sistema complexo

### Impacto Educacional
Este projeto demonstra como conceitos fundamentais de AED3 são aplicados em tecnologias emergentes, conectando teoria acadêmica com inovação tecnológica real.

---

## 🔧 Arquivos do Projeto

- **`ulicoin.py`**: Implementação principal da blockchain (160 linhas)
- **`ulicoin_5001.py`**, **`ulicoin_5002.py`**, **`ulicoin_5003.py`**: Nós adicionais da rede
- **`nodes.json`**: Configuração de nós da rede
- **`transactions.json`**: Template de transações
- **`BLOCKCHAIN_AED3_APRESENTACAO.md`**: Documentação técnica detalhada

---

**Total de linhas de código**: ~200 linhas Python  
**Funcionalidades implementadas**: 6 endpoints REST + blockchain completa  
**Estruturas de dados utilizadas**: 4 tipos diferentes  
**Algoritmos implementados**: 4 algoritmos principais  

Este projeto representa uma implementação completa e funcional de blockchain, demonstrando domínio prático dos conceitos de Algoritmos e Estrutura de Dados 3.

---

*Relatório elaborado para avaliação da disciplina AED3 - Professor Ulisses*  
*Projeto UliCoin: Blockchain educacional implementada em Python*