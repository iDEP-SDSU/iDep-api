import axios from "~/plugins/axios"

export const state = () => ({
  users: [ {id: 0 , login: "k"}],
  status: {status: "Not Ready", time: ""},
  transData: {
      log:[],
      log2:[],
      vst:[]
  },
  logs: [
    {id:0, desc:"iDEP is ready.", title:"Welcome"},
    {id:1, desc:"Your Session is ready.", title:"User Session"},
    {id:1, desc:"Your Date is ready.", title:"Load Data"}
  ]
})

export const mutations = {
    setUsers(state, users){
        state.users = users
    },
    setTransData(state, trans){
        state.transData[trans.name] = trans.data
    },
    setStatus(state, status){
        state.status = status
    }
}
export const actions = {
    async LOAD_STATUS({commit}, dataUrl) {
        const response = await axios.get("status")
        // const ids = response.data
        // const tenIds = ids
        // const itemsPromises = tenIds.map(id => axios.get(`${id}`.json))
        // const itemsResponses = await Promise.all(itemsPromises)
        // const items = itemsResponses.map(res => res.data)
        commit("setStatus", response.data)
        // const users = response.data
        // commit("setUsers", users)
    },
    async GET_TRANS({commit}, name){
        const response= await axios.get(`transform/${name}`)
        const data = {
            name: name, 
            data: response.data
        }
        commit("setTransData", data)
        console.log(`TransData ${name} is ready.` )
    },
    async nuxtServerInit({commit}) {
        // const response= await axios.get("users")
        // console.log(response.data)
        // const users = response.data
        // commit("setUsers", users)
    },
    async nuxtServerInit({commit}) {
        // const response= await axios.get("users")
        // console.log(response.data)
        // const users = response.data
        // commit("setUsers", users)
    }
}