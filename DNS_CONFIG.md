# 自定义域名 `lsgyl.xyz` 接入 Vercel 指南

已将你的域名 `lsgyl.xyz` 添加到 Vercel 项目 `zhoutao-s-projects/codex-claude-site` 中。
现在需要在域名注册商（万网/阿里云）后台配置 DNS，让域名指向 Vercel 服务器。

## 当前状态

- 域名已解析到 Vercel IP：`76.76.21.21` ✅
- Vercel 项目已关联：`codex-claude-site` ✅
- SSL 证书正在自动申请中，通常几分钟内完成。

## 推荐方案：添加 A 记录

Vercel 验证后建议 apex 域名（根域名）使用两条 A 记录以获得最佳 CDN 路由：

1. 登录你的域名注册商控制台（当前 nameserver 是 `dns31.hichina.com` / `dns32.hichina.com`，说明是万网/阿里云 DNS）。
2. 进入 **域名解析 / DNS 解析** 设置。
3. 删除旧的 `lsgyl.xyz` A 记录（如果有）。
4. 添加两条 **A 记录**：

| 主机记录 | 记录类型 | 记录值 | TTL |
|---|---|---|---|
| `@` | `A` | `216.198.79.1` | 默认/600 |
| `@` | `A` | `64.29.17.1` | 默认/600 |

5. （可选）如果你也想用 `www.lsgyl.xyz`，再加一条 **CNAME 记录**：
   - **主机记录**：`www`
   - **记录类型**：`CNAME`
   - **记录值**：`cname.vercel-dns.com`
   - **TTL**：默认即可

6. 保存后等待 DNS 生效，通常几分钟到 1 小时。

## 备选方案：修改 NS 服务器（把 DNS 完全交给 Vercel）

如果你不想手动管理 A 记录，可以把域名的 nameserver 改为：

- `ns1.vercel-dns.com`
- `ns2.vercel-dns.com`

> 注意：改 nameserver 后，原来的 MX、TXT 等记录会失效，如果你有用这个域名发邮件，请谨慎选择。

## 验证域名是否生效

配置完成后，在命令行运行：

```bash
nslookup lsgyl.xyz
```

如果返回 `216.198.79.1` 或 `64.29.17.1`，说明 A 记录已生效。

然后让 Vercel 立即验证：

```bash
cd C:/Users/GIGABYTE/WorkBuddy/2026-06-29-13-21-15/codex-claude-site
npx vercel@latest domains verify lsgyl.xyz
```

验证通过后，网站即可通过 `https://lsgyl.xyz` 访问。

## 完成后你将拥有的访问地址

| 地址 | 说明 |
|---|---|
| `https://lsgyl.xyz` | 你的自定义域名（推荐） |
| `https://cc-ai-guide.vercel.app` | Vercel 短别名 |
| `https://codex-claude-site.vercel.app` | Vercel 默认域名 |

## 常见问题

**Q：配置后访问显示 404 或不安全提示？**  
A：说明 DNS 还没生效，或 Vercel 还没完成 SSL 证书签发。等几分钟再刷新，或运行 `npx vercel@latest domains verify lsgyl.xyz` 触发重新验证。

**Q：为什么之前是 `76.76.21.21`，现在变成 `216.198.79.1` 和 `64.29.17.1`？**  
A：`76.76.21.21` 也能解析到 Vercel，但 Vercel 对 apex 域名更推荐使用这两条 A 记录，CDN 路由更优。

**Q：我想用 HTTPS，需要手动配置证书吗？**  
A：不需要。Vercel 会自动为自定义域名申请并续期 Let's Encrypt SSL 证书。
