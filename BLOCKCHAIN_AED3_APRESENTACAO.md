# UliCoin: Blockchain e Criptomoedas
## Trabalho de Algoritmos e Estrutura de Dados 3

### Professor: Ulisses
### Aluno: [Seu Nome]
### Data: [Data da Apresentação]

---

## 📚 Sumário

1. [Introdução ao Blockchain](#introdução-ao-blockchain)
2. [Estruturas de Dados Utilizadas](#estruturas-de-dados-utilizadas)
3. [Algoritmos Implementados](#algoritmos-implementados)
4. [Análise de Complexidade](#análise-de-complexidade)
5. [Arquitetura da UliCoin](#arquitetura-da-ulicoin)
6. [Funcionalidades Implementadas](#funcionalidades-implementadas)
7. [Segurança e Consenso](#segurança-e-consenso)
8. [Demonstração Prática](#demonstração-prática)
9. [Conclusões](#conclusões)

---

## 🔗 Introdução ao Blockchain

### O que é Blockchain?
Uma **blockchain** é uma estrutura de dados distribuída que mantém uma lista crescente de registros (blocos) conectados e protegidos usando criptografia. Cada bloco contém:

- **Hash do bloco anterior**: Cria a "cadeia"
- **Timestamp**: Marca temporal
- **Dados das transações**: Informações a serem armazenadas
- **Nonce/Proof**: Prova de trabalho computacional

### Características Fundamentais
- **Descentralização**: Sem autoridade central
- **Imutabilidade**: Dados não podem ser alterados retroativamente
- **Transparência**: Todas as transações são públicas
- **Consenso**: Acordo entre todos os nós da rede

---

## 🏗️ Estruturas de Dados Utilizadas

### 1. Lista Ligada (Blockchain Chain)
```python
self.chain = []  # Lista que armazena todos os blocos
```
- **Complexidade de Inserção**: O(1)
- **Complexidade de Busca**: O(n)
- Cada bloco aponta para o anterior via hash

### 2. Hash Table (Dicionários Python)
```python
block = {
    'index': len(self.chain) + 1,
    'timestamp': str(datetime.datetime.now()),
    'proof': proof,
    'previous_hash': previous_hash,
    'transactions': self.transactions
}
```
- **Complexidade de Acesso**: O(1)
- Armazena dados estruturados do bloco

### 3. Set (Conjunto de Nós)
```python
self.nodes = set()  # Armazena endereços únicos dos nós
```
- **Complexidade de Inserção**: O(1)
- **Complexidade de Busca**: O(1)
- Garante unicidade dos nós da rede

### 4. Array/Lista (Pool de Transações)
```python
self.transactions = []  # Transações pendentes
```
- **Complexidade de Inserção**: O(1)
- **Complexidade de Remoção**: O(n)

---

## ⚙️ Algoritmos Implementados

### 1. Algoritmo de Hash (SHA-256)
```python
def hash(self, block):
    encoded_block = json.dumps(block, sort_keys=True).encode()
    return hashlib.sha256(encoded_block).hexdigest()
```
- **Função criptográfica unidirecional**
- **Propriedade**: Pequenas mudanças → hash completamente diferente
- **Segurança**: 2^256 possibilidades

### 2. Proof of Work (Prova de Trabalho)
```python
def proof_of_work(self, previous_proof):
    new_proof = 1
    check_proof = False
    while check_proof is False:
        hash_operation = hashlib.sha256(str(new_proof**2 - previous_proof**2).encode()).hexdigest()
        if hash_operation[:4] == '0000':  # Dificuldade: 4 zeros
            check_proof = True
        else:
            new_proof += 1
    return new_proof
```
- **Objetivo**: Encontrar um número que gere hash com padrão específico
- **Dificuldade**: Ajustável (número de zeros iniciais)
- **Consumo**: Computacionalmente intensivo

### 3. Validação de Cadeia
```python
def is_chain_valid(self, chain):
    previous_block = chain[0]
    block_index = 1
    while block_index < len(chain):
        # Validações de integridade
```
- **Verifica**: Integridade de cada bloco
- **Confirma**: Sequência correta de hashes
- **Complexidade**: O(n * m), onde n = blocos, m = transações

### 4. Consenso da Rede (Longest Chain Rule)
```python
def replace_chain(self):
    # Substitui por cadeia mais longa e válida
```
- **Algoritmo de consenso**: Aceita a cadeia mais longa
- **Resolve conflitos**: Entre diferentes versões da blockchain

---

## 📊 Análise de Complexidade

### Operações Principais

| Operação | Complexidade Temporal | Complexidade Espacial | Justificativa |
|----------|----------------------|----------------------|---------------|
| Adicionar Bloco | O(1) | O(1) | Inserção no final da lista |
| Validar Cadeia | O(n) | O(1) | Percorre todos os blocos |
| Proof of Work | O(k) | O(1) | k = dificuldade (exponencial) |
| Buscar Transação | O(n*m) | O(1) | n blocos, m transações |
| Sincronizar Rede | O(r*n) | O(n) | r nós, n blocos |

### Escalabilidade
- **Crescimento Linear**: Tempo de validação cresce com tamanho da chain
- **Gargalo Principal**: Proof of Work (mineração)
- **Trade-off**: Segurança vs Velocidade

---

## 🪙 Arquitetura da UliCoin

### Componentes do Sistema

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   UliCoin Node  │    │   UliCoin Node  │    │   UliCoin Node  │
│   (Port 5000)   │◄──►│   (Port 5001)   │◄──►│   (Port 5002)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         ▲                       ▲                       ▲
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Blockchain    │    │   Blockchain    │    │   Blockchain    │
│   Local Copy    │    │   Local Copy    │    │   Local Copy    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Rede Descentralizada
- **Múltiplos nós**: Executando em portas diferentes
- **Comunicação P2P**: Via requisições HTTP
- **Sincronização**: Automática entre nós
- **Tolerância a falhas**: Funciona mesmo com nós offline

---

## 🔧 Funcionalidades Implementadas

### 1. Mineração de Blocos
**Endpoint**: `GET /mine_block`
```json
{
    "message": "[AED3] UliCoin: Bloco minerado com sucesso!",
    "index": 2,
    "timestamp": "2024-01-15 10:30:45.123456",
    "proof": 12345,
    "previous_hash": "abc123...",
    "transactions": [...]
}
```

### 2. Visualização da Blockchain
**Endpoint**: `GET /get_chain`
```json
{
    "chain": [...],
    "length": 5
}
```

### 3. Validação da Integridade
**Endpoint**: `GET /is_valid`
```json
{
    "message": "[AED3] UliCoin: Blockchain válido - Estrutura de dados íntegra!"
}
```

### 4. Sistema de Transações
**Endpoint**: `POST /add_transaction`
```json
{
    "sender": "Prof. Ulisses",
    "receiver": "Estudante AED3",
    "amount": 10
}
```

### 5. Gerenciamento de Rede
**Endpoint**: `POST /connect_node`
**Endpoint**: `GET /replace_chain`

---

## 🔐 Segurança e Consenso

### Mecanismos de Segurança

#### 1. Função Hash Criptográfica
- **SHA-256**: Padrão da indústria
- **Propriedades**:
  - Determinística
  - Unidirecional
  - Resistente a colisões
  - Efeito avalanche

#### 2. Proof of Work
- **Previne spam**: Requer esforço computacional
- **Dificulta alterações**: Custo proibitivo para reescrever histórico
- **Dificuldade ajustável**: 4 zeros iniciais (2^16 tentativas em média)

#### 3. Validação Distributiva
- **Consenso da maioria**: Longest chain rule
- **Verificação cruzada**: Múltiplos nós validam
- **Rejeição automática**: Blocos inválidos são descartados

### Análise de Ataques Possíveis

#### Ataque 51%
- **Descrição**: Controlar >50% do poder computacional
- **Mitigação**: Descentralização da rede
- **Na UliCoin**: Demonstrativo educacional

#### Double Spending
- **Descrição**: Gastar mesmas moedas duas vezes
- **Prevenção**: Validação de transações em toda a rede
- **Confirmações**: Múltiplos blocos confirmam transação

---

## 💻 Demonstração Prática

### Cenário 1: Mineração de Bloco
```bash
# Iniciar nó principal
python ulicoin.py

# Minerar primeiro bloco
curl http://127.0.0.1:5000/mine_block

# Resultado: Bloco com transação para Prof. Ulisses
```

### Cenário 2: Rede Distribuída
```bash
# Iniciar múltiplos nós
python ulicoin_5001.py
python ulicoin_5002.py
python ulicoin_5003.py

# Conectar nós
curl -X POST -H "Content-Type: application/json" \
     -d '{"nodes": ["127.0.0.1:5001", "127.0.0.1:5002"]}' \
     http://127.0.0.1:5000/connect_node
```

### Cenário 3: Sincronização
```bash
# Minerar em nó específico
curl http://127.0.0.1:5001/mine_block

# Sincronizar outros nós
curl http://127.0.0.1:5000/replace_chain
```

### Cenário 4: Transações Personalizadas
```bash
curl -X POST -H "Content-Type: application/json" \
     -d '{"sender": "Prof. Ulisses", "receiver": "Estudante AED3", "amount": 100}' \
     http://127.0.0.1:5000/add_transaction
```

---

## 🎓 Relevância para AED3

### Estruturas de Dados Aplicadas
- **Listas Ligadas**: Cadeia de blocos sequencial
- **Hash Tables**: Armazenamento eficiente de dados
- **Sets**: Gerenciamento de nós únicos
- **Arrays**: Pool de transações pendentes

### Algoritmos Fundamentais
- **Hashing**: SHA-256 para integridade
- **Busca**: Validação de transações
- **Consenso**: Algoritmo de acordo distribuído
- **Grafos**: Topologia de rede P2P

### Análise de Complexidade
- **Temporal**: O(1) a O(n*m) dependendo da operação
- **Espacial**: Crescimento linear com dados
- **Trade-offs**: Segurança vs Performance

---

## 🚀 Aplicações e Extensões

### Casos de Uso Reais
- **Criptomoedas**: Bitcoin, Ethereum
- **Supply Chain**: Rastreamento de produtos
- **Contratos Inteligentes**: Acordos automatizados
- **Identidade Digital**: Certificados imutáveis
- **Votação Eletrônica**: Sistemas transparentes

### Possíveis Melhorias
- **Merkle Trees**: Validação eficiente de transações
- **Proof of Stake**: Algoritmo de consenso mais eficiente
- **Sharding**: Divisão da blockchain para escalabilidade
- **Lightning Network**: Transações off-chain
- **Smart Contracts**: Lógica programável

---

## 📈 Conclusões

### Aprendizados Principais
1. **Blockchain combina múltiplas estruturas de dados** de forma inovadora
2. **Trade-offs são fundamentais**: Segurança, velocidade, descentralização
3. **Algoritmos criptográficos** garantem integridade sem autoridade central
4. **Consenso distribuído** resolve problemas clássicos de sistemas distribuídos

### Impacto Tecnológico
- **Revolução na confiança**: Elimina intermediários
- **Novos paradigmas**: Descentralização como padrão
- **Aplicações infinitas**: Além das criptomoedas

### Relevância Acadêmica
- **AED3 na prática**: Estruturas e algoritmos em aplicação real
- **Complexidade computacional**: Análise de performance crítica
- **Sistemas distribuídos**: Conceitos fundamentais aplicados

---

## 📚 Referências e Estudos Futuros

### Bibliografia Técnica
- Nakamoto, S. (2008). Bitcoin: A Peer-to-Peer Electronic Cash System
- Cormen et al. Introduction to Algorithms (análise de complexidade)
- Documentação Python: hashlib, Flask, requests

### Próximos Passos
- Implementação de Merkle Trees
- Interface web interativa
- Análise comparativa de algoritmos de consenso
- Estudo de casos de uso em diferentes indústrias

---

*Este documento serve como base para apresentação sobre blockchain e criptomoedas, demonstrando a aplicação prática de conceitos de Algoritmos e Estrutura de Dados 3 na construção da UliCoin.*

**Desenvolvido para a disciplina AED3 - Professor Ulisses**