const User=require ("../models/User")

module.exports={
    getUser: async(req,res)=> {
        try {
            const user =await User.findById(req.user.id);
            const{password,__v,createdAt, updatedAt,...userData}=user._doc;
            res.status(200).json(userData)
        } catch (error) {
            res.status(500).json(error)
        }
    },
    delete: async(req,res)=>{
        try {
            await User.findByIdAndDelete(req.user.id);
            res.status(200).json("User deleted successfully")

        } catch (error) {
            res.status(500).json(error)

            
        }
    }

}