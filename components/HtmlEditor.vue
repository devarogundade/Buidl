<template>
<editor api-key="spv74bpcewqudcw2pw0vx3bnw4k5cib6cyzo3uj5h3agmybo" :init="{
         height: height ? height : 400,
         menubar: false,
          toolbar_mode: 'sliding',
          contextmenu: 'link image table',
          skin:  'oxide-dark',
          content_css: 'dark',
         editimage_cors_hosts: ['picsum.photos'],
         plugins: [
           'preview importcss searchreplace autolink autosave save directionality code visualblocks visualchars fullscreen image link media template codesample table charmap pagebreak nonbreaking anchor insertdatetime advlist lists wordcount help charmap quickbars emoticons'
         ],
         toolbar:
           'undo redo | bold italic underline strikethrough | fontfamily fontsize blocks | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview save print | insertfile image media template link anchor codesample | ltr rtl'
       }" />
</template>

<script>
import Editor from '@tinymce/tinymce-vue'
export default {
    props: ['height'],
    components: {
        'editor': Editor
    },
}
</script>
