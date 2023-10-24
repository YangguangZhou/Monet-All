import { createRequire } from 'module'
import { defineConfig } from 'vitepress'

// import locales from './locales'
import en from './locales/en.ts'

const require = createRequire(import.meta.url)
const pkg = require('vitepress/package.json')

export default defineConfig({
  title: 'Monet All',
  lang: 'zh-CN',
  description: '莫奈取色整合Magisk模块',
  cleanUrls: true,
  // locales: locales.locales,
  // srcDir: './docs',
  lastUpdated: true,
  head: [
    [
      'script',
      { async: '', 'data-website-id': 'c25f86e1-29ad-48cc-865c-c0f02b56821f', src: 'https://analytics.umami.is/script.js' }
    ],
    [
      'script',
      { async: '', src: 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2597042766299857', crossorigin: 'anonymous' } 
    ],
    [
      'script',
      { defer: '', src: '/_vercel/insights/script.js' }
    ]
    // <script async src="https://analytics.umami.is/script.js" data-website-id="c25f86e1-29ad-48cc-865c-c0f02b56821f"></script>
    // <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2597042766299857" crossorigin="anonymous"></script>
    // <script defer src="/_vercel/insights/script.js"></script>
  ],
  locales: {
    root: {
      label: '简体中文',
      lang: 'zh_CN'
    },
    en: {
      label: 'English',
      lang: 'en',
      link: '/en/',
      themeConfig: en.themeConfig,
      description: en.description
    },
  },
  themeConfig: {
    nav: nav(),
    outlineTitle: '本文目录',
    darkModeSwitchLabel: '外观',
    sidebarMenuLabel: '目录',
    returnToTopLabel: '回到顶部',
    sidebar: {
      '/guide/': sidebarGuide()
    },
    lastUpdatedText: '最后更新',
    socialLinks: [
      { icon: 'github', link: 'https://github.com/YangguangZhou/Monet-All' },
      {
        icon: {
          svg: '<svg t="1679664028332" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1215" width="200" height="200"><path d="M679.424 746.861714l84.004571-395.995428c7.424-34.852571-12.580571-48.566857-35.437714-40.009143l-493.714286 190.281143c-33.718857 13.129143-33.133714 32-5.705142 40.557714l126.281142 39.424 293.156572-184.576c13.714286-9.142857 26.294857-3.986286 16.018286 5.156571l-237.129143 214.272-9.142857 130.304c13.129143 0 18.870857-5.705143 25.709714-12.580571l61.696-59.428571 128 94.281142c23.442286 13.129143 40.009143 6.290286 46.299428-21.723428zM1024 512c0 282.843429-229.156571 512-512 512S0 794.843429 0 512 229.156571 0 512 0s512 229.156571 512 512z" fill="" p-id="1216"></path></svg>'
        },
        link: 'https://t.me/Monet_All'
      }

    ],
    docFooter: {
      prev: '上一篇',
      next: '下一篇'
    },
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2022-2023 Jerry Zhou(https://jerryz.com.cn)'
    },
    editLink: {
      pattern: 'https://github.com/YangguangZhou/Monet-All/blob/docs/docs/:path',
      text: '在 GitHub 中编辑本页'
    },
    // localSearch: {
    //   locales: {
    //     zh: {
    //       translations: {
    //         button: {
    //           buttonText: '搜索文档',
    //           buttonAriaLabel: '搜索文档'
    //         },
    //         modal: {
    //           noResultsText: '无法找到相关结果',
    //           resetButtonTitle: '清除查询条件',
    //           footer: {
    //             selectText: '选择',
    //             navigateText: '切换'
    //           }
    //         }
    //       }
    //     }
    //   }
    // },
    algolia: {
      appId: 'T4RVBHOPQE',
      apiKey: 'f2da4e2a79ae9edc46037ffa47f8f019',
      indexName: 'monet-jerryz-com',
      placeholder: '搜索文档',
      translations: {
        button: {
          buttonText: '搜索'
        },
        modal: {
          searchBox: {
            resetButtonTitle: '清除查询条件',
            resetButtonAriaLabel: '清除查询条件',
            cancelButtonText: '取消',
            cancelButtonAriaLabel: '取消'
          },
          startScreen: {
            recentSearchesTitle: '搜索历史',
            noRecentSearchesText: '没有搜索历史',
            saveRecentSearchButtonTitle: '保存到搜索历史',
            removeRecentSearchButtonTitle: '从搜索历史中移除',
            favoriteSearchesTitle: '收藏',
            removeFavoriteSearchButtonTitle: '从收藏中移除'
          },
          errorScreen: {
            titleText: '无法获取结果',
            helpText: '你可能需要检查你的网络连接'
          },
          footer: {
            selectText: '选择',
            navigateText: '切换',
            closeText: '关闭',
            searchByText: '搜索供应商'
          },
          noResultsScreen: {
            noResultsText: '无法找到相关结果',
            suggestedQueryText: '你可以尝试查询',
            reportMissingResultsText: '你认为这个查询应该有结果？',
            reportMissingResultsLinkText: '向我们反馈'
          }
        }
      },
    },
    logo: 'https://img.examcoo.com/ask/7386438/202303/167966740456420.png',
  }
})

function nav() {
  return [
    { text: '指南', link: '/guide/introduction' },
    { text: 'Github', link: 'https://github.com/YangguangZhou/Monet-All' }
  ]
}

function sidebarGuide() {
  return [
    {
      text: '介绍',
      items: [
        { text: 'Monet All', link: '/guide/introduction' },
        { text: '包含的应用及原作者', link: '/guide/apps' },
        { text: '常见问题', link: '/guide/faq' },
      ]
    },
    {
      text: '下载安装',
      items: [
        { text: '下载', link: '/guide/download' },
        { text: '安装', link: '/guide/install' },
        { text: '更新日志', link: '/guide/changelog' },
        { text: '其它应用及模块', link: '/guide/apks' },
      ]
    },
    {
      text: '其它',
      items: [
        { text: '交流群', link: '/guide/group' },
        { text: '捐赠', link: '/guide/donate' },
        { text: '关于作者', link: '/guide/about' },
      ]
    },
  ]
}

