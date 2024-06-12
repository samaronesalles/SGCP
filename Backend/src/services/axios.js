const axios = require('axios')

module.exports = {

    makeGet(url, endpoint, tokenType, accessToken) {
        return new Promise((resolve, reject) => {
            let respostaFinal = {
                statusCode: 200,
                error: true,
                data: {}
            }

            try {
                const URL = `${url}/${endpoint}`
                const AUTHORIZATION = `${tokenType} ${accessToken}`

                let axiosConfig = {}
                if (AUTHORIZATION.trim() !== "") {
                    axiosConfig["headers"] = { "Authorization": AUTHORIZATION }
                }

                axios.get(URL, axiosConfig)
                    .then(response => {
                        if ([200, 201].includes(response.status)) {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = false
                            respostaFinal.data = response.data

                            resolve(respostaFinal)
                        } else {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = true
                            respostaFinal.data = response // sem o ".data" mesmo..

                            reject(respostaFinal)
                        }
                    })
                    .catch((err) => {
                        respostaFinal.statusCode = err?.response?.status || 400
                        respostaFinal.error = true

                        try {
                            respostaFinal.data = err.isAxiosError ? err.response.data : err
                        } catch {
                            respostaFinal.data = err.message || err
                        }

                        reject(respostaFinal)
                    })

            } catch (e) {
                respostaFinal.statusCode = 400
                respostaFinal.error = true
                respostaFinal.data = {
                    error: e.name,
                    error_description: e.message
                }

                reject(respostaFinal)
            }

        })
    },

    makePost(url, endpoint, tokenType, accessToken, body, contentType) {
        return new Promise((resolve, reject) => {
            let respostaFinal = {
                statusCode: 200,
                error: true,
                data: {}
            }

            try {
                const URL = `${url}/${endpoint}`
                const AUTHORIZATION = `${tokenType} ${accessToken}`
                const BODY = body
                const CONTENT_TYPE = contentType || "application/json"

                let axiosConfig = {
                    "Content-Type": CONTENT_TYPE
                }

                if (AUTHORIZATION.trim() !== "") {
                    axiosConfig["headers"] = { "Authorization": AUTHORIZATION }
                }

                let data = BODY
                if (CONTENT_TYPE.match(/form-urlencoded/)) {
                    data = Object.keys(BODY)
                        .map((key) => `${key}=${encodeURIComponent(BODY[key])}`)
                        .join('&')
                }

                axios.post(URL, data, axiosConfig)
                    .then(response => {
                        if ([200, 201].includes(response.status)) {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = false
                            respostaFinal.data = response.data?.data || response.data

                            resolve(respostaFinal)
                        } else {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = true
                            respostaFinal.data = response?.data || response

                            reject(respostaFinal)
                        }
                    })
                    .catch((err) => {
                        respostaFinal.statusCode = err?.response?.status || 400
                        respostaFinal.error = true

                        try {
                            respostaFinal.data = err.isAxiosError ? err.response.data : err
                        } catch {
                            respostaFinal.data = err.message || err
                        }

                        reject(respostaFinal)
                    })
            } catch (e) {
                respostaFinal.statusCode = 400
                respostaFinal.error = true
                respostaFinal.data = {
                    error: e.name,
                    error_description: e.message
                }

                reject(respostaFinal)
            }
        })

    },

    makePut(url, endpoint, tokenType, accessToken, body, contentType) {
        return new Promise((resolve, reject) => {
            let respostaFinal = {
                statusCode: 200,
                error: true,
                data: {}
            }

            try {
                const URL = `${url}/${endpoint}`
                const AUTHORIZATION = `${tokenType} ${accessToken}`
                const BODY = body
                const CONTENT_TYPE = contentType || "application/json"

                let axiosConfig = {
                    "Content-Type": CONTENT_TYPE
                }

                if (AUTHORIZATION.trim() !== "") {
                    axiosConfig["headers"] = { "Authorization": AUTHORIZATION }
                }

                let data = BODY
                if (CONTENT_TYPE.match(/form-urlencoded/)) {
                    data = Object.keys(BODY)
                        .map((key) => `${key}=${encodeURIComponent(BODY[key])}`)
                        .join('&')
                }

                axios.put(URL, data, axiosConfig)
                    .then(response => {
                        if ([200, 201].includes(response.status)) {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = false
                            respostaFinal.data = response.data?.data || response.data

                            resolve(respostaFinal)
                        } else {
                            respostaFinal.statusCode = response.status
                            respostaFinal.error = true
                            respostaFinal.data = response?.data || response

                            reject(respostaFinal)
                        }
                    })
                    .catch((err) => {
                        respostaFinal.statusCode = err?.response?.status || 400
                        respostaFinal.error = true

                        try {
                            respostaFinal.data = err.isAxiosError ? err.response.data : err
                        } catch {
                            respostaFinal.data = err.message || err
                        }

                        reject(respostaFinal)
                    })

            } catch (e) {
                respostaFinal.statusCode = 400
                respostaFinal.error = true
                respostaFinal.data = {
                    error: e.name,
                    error_description: e.message
                }

                reject(respostaFinal)
            }
        })

    },

}