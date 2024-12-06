const USER_KEY = 'user'
const TOKEN_KEY = 'token'

interface User {
  id: string
  username: string
  role: string
  clientInfoId: string
  numberWorkers: number
  ownedFacility: boolean
  serviceOrProduct: string
}

const getUser = () => {
  return JSON.parse(localStorage.getItem(USER_KEY) || '{}')
}

const getToken = () => {
  return localStorage.getItem(TOKEN_KEY)
}

const setUser = (user: User) => {
  localStorage.setItem(USER_KEY, JSON.stringify(user))
}

const setToken = (token: string) => {
  localStorage.setItem(TOKEN_KEY, token)
}

const clearStorage = () => {
  localStorage.clear()
}

export { clearStorage, getToken, getUser, setToken, setUser }
