//
import axios from "~/plugins/axios"
export const state = () => ({
  users: [ {id: 0 , login: "k"}]
})

export const mutations = {
    setUsers(state, users){
        state.users = users
    }
}
export const actions = {
    async nuxtServerInit({commit}) {
        // const response= await axios.get("users")
        // console.log(response.data)
        // const users = response.data
        // commit("setUsers", users)
    }
}