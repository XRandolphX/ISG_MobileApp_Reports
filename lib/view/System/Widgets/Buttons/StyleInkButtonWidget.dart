/*

            //Botón Nuevo Reporte
            InkWell(
              onTap: () {
                
              },
              child: Container(
                width: 150.0,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 20),
                          blurRadius: 30.0,
                          color: Colors.black12)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 100.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 12.0),
                      decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(95.0),
                              topLeft: Radius.circular(95.0),
                              bottomRight: Radius.circular(200.0))),
                      child: Text(
                        'Nuevo Reporte',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.apply(color: Colors.black),
                      ),
                    ),
                    const Icon(
                      Icons.article_outlined,
                      size: 30.0,
                    )
                  ],
                ),
              ),
            ),
*/