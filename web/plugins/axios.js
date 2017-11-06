import axios from "axios"

export default axios.create({ 
  baseURL : "http://bioinformatics.sdstate.edu:5432"
})