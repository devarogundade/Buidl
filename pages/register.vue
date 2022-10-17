<template>
<div class="register">
    <Register :user="user" />
</div>
</template>

<script>
export default {
    props: ['user'],
    layout: 'landing'
}
</script>
