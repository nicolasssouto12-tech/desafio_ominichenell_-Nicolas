use('omnichannel_nosql');

db.getCollection('logs_navegacao').insertMany([
    {
        cliente_id: 101,
        data_hora: new Date(),
        pagina_visitada: "/produto/smartphone-galaxy-s23",
        dispositivo: "Mobile",
        acao: "visualizou_produto"
    },
    {
        cliente_id: 102,
        data_hora: new Date(),
        pagina_visitada: "/carrinho",
        dispositivo: "Desktop",
        acao: "abriu_carrinho"
    },
    {
        cliente_id: 103,
        data_hora: new Date(),
        pagina_visitada: "/busca",
        dispositivo: "Mobile",
        acao: "pesquisou_produto"
    }
]);

db.getCollection('logs_navegacao').find({});