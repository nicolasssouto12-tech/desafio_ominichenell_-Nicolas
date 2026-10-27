# Projeto Sistema de Gestão OmniChannel

**Aluno:** Nicolas do Nascimento Souto

## Sobre o projeto

O projeto Sistema de Gestão OmniChannel tem como objetivo criar um banco de dados para gerenciar clientes, lojas, produtos, pedidos, estoque e pagamentos, utilizando SQL e ferramentas de banco de dados.

## Passo a passo do desenvolvimento

**1. Criação do banco de dados:** foi criado o banco `omnichannel_db`, responsável por armazenar todas as informações do sistema.

**2. Criação das tabelas:** foram criadas as tabelas Clientes, Loja, Produto, Pedido, item_pedido, Estoques, pagamentos e Auditoria_preco. As chaves primárias identificam os registros, enquanto as chaves estrangeiras relacionam as tabelas.

**3. Inserção dos dados:** foram adicionados registros de exemplo para permitir testar o funcionamento do banco e consultar as informações por meio de comandos SQL, como `INSERT INTO` e `SELECT`.

**4. Configuração da segurança:** foram criados cargos para atendente e gerência, com permissões diferentes para controlar o acesso aos dados.

**5. Automação e testes:** foi criada uma procedure para processar vendas, registrar pedidos e pagamentos e atualizar o estoque. Também foi criada uma trigger para registrar alterações nos preços, uma view para consultar o relatório de vendas e um índice para auxiliar as consultas por data.

**6. Validação do sistema:** foram realizados testes com consultas SQL para verificar os registros, conferir o estoque após uma venda e verificar o funcionamento da auditoria de preços.

**7. Organização da entrega:** os arquivos SQL, o diagrama do banco de dados, o backup e a documentação devem ser organizados no repositório do GitHub. A etapa com MongoDB Atlas também deve ser realizada e validada caso ainda não tenha sido concluída.

## Conclusão

O projeto permitiu aplicar conhecimentos de modelagem de dados, SQL, relacionamentos entre tabelas, segurança, automação e consultas. Dessa forma, o banco de dados oferece uma estrutura organizada para auxiliar no controle das operações comerciais de uma empresa OmniChannel.

