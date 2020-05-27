<!--suppress ALL -->
<template>
        <el-radio-group
                v-model="_value"
                @change="onChange"
                :size="size"
                :fill="fill"
                :text-color="textColor"
                :disabled="disabled"
                :style="{width: width + 'px'}">
            <el-radio v-for="option in options" :label="option[valueField]" :key="option[valueField]">{{option[textField]}}
            </el-radio>
        </el-radio-group>
</template>
<script>
    export default {
        data:function(){
            return {
                options: [],
            };
        },
        computed:{
            _value: {
                get:function() {
                    return this.value;
                },
                set:function(val) {
                    this.$emit('input', val);
                }
            },
        },
        props: {
            url: {
                type: String,
                required: true
            },
            value: {
                type: [String, Number, Array],
                default: ''
            },
            valueField: {
                type: String,
                default: 'id'
            },
            textField: {
                type: String,
                default: 'description'
            },
            size: {
                validator (value) {
                    var list = ['small','large','mini'];
                    return list.indexOf(value) > -1;
                },
            },
            disabled: {
                type: Boolean,
                default: false
            },
            width: {
                type: [Number, String],
                default:'100%',
            },
            fill:{
                type:String,
                default:'#20a0ff'
            },
            textColor:{
                type:String,
                default:'#ffffff'
            }
        },
        watch: {
            url: function(){
                this.reload();
            },
        },
        methods: {
            reload:function(){
                var self = this;
                if(this.url){
                    this.$post(this.url,function(json) {
                        self.options = json.data || [];
                    }, function(json){
                        self.$message.error({
                            message: json['tooltip'] || '加载数据失败!',
                        });
                    });
                }
            },
            onChange:function(selected){
                this.$emit('change', selected);
            }
        },
        created:function(){
        },
        mounted:function(){
            this.reload();
        }
    };
</script>
