const mysql = require('mysql2')
const connection = {
    query: async (query_string) => new Promise(async (resolve, reject) => {
        let connection_pool

        try {

            connection_pool = mysql.createConnection({
                host: 'localhost',
                user: 'root',
                password: '',
                database: 'backend_challenge'
            })
            connection_pool.query(
                query_string, function (error, results, fields) {
                    if (error) reject (error)
                    else resolve (results)
                }
            )

        }
        catch (ex) {
            reject (ex)
        }
        finally {
            connection_pool.end()
        }
    }
    )
}
module.exports = connection